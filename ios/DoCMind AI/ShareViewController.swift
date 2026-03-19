import UIKit
import Social
import MobileCoreServices
import Photos
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {
    var hostAppBundleIdentifier = ""
    var appGroupId = ""
    let sharedKey = "ShareKey"
    let sharedMessageKey = "ShareMessageKey"
    var sharedMedia: [RSISharedMediaFile] = []

    override func isContentValid() -> Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadIds()
    }

    override func didSelectPost() {
        saveAndRedirect(message: contentText)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let content = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachments = content.attachments, !attachments.isEmpty else {
            close()
            return
        }

        for (index, attachment) in attachments.enumerated() {
            for type in RSISharedMediaType.allCases {
                if attachment.hasItemConformingToTypeIdentifier(type.toUTTypeIdentifier) {
                    attachment.loadItem(forTypeIdentifier: type.toUTTypeIdentifier) { [weak self] data, error in
                        guard let this = self, error == nil else {
                            self?.close()
                            return
                        }
                        switch type {
                        case .text:
                            if let text = data as? String {
                                this.handleLiteral(text, type: type, index: index, content: content)
                            }
                        case .url:
                            if let url = data as? URL {
                                this.handleLiteral(url.absoluteString, type: type, index: index, content: content)
                            }
                        default:
                            if let url = data as? URL {
                                this.handleFile(url, type: type, index: index, content: content)
                            } else if let image = data as? UIImage {
                                this.handleUIImage(image, type: type, index: index, content: content)
                            }
                        }
                    }
                    break
                }
            }
        }
    }

    override func configurationItems() -> [Any]! { return [] }

    private func loadIds() {
        let extensionBundleId = Bundle.main.bundleIdentifier!
        let lastDot = extensionBundleId.lastIndex(of: ".")!
        hostAppBundleIdentifier = String(extensionBundleId[..<lastDot])

        let defaultGroupId = "group.\(hostAppBundleIdentifier)"
        let customGroupId = Bundle.main.object(forInfoDictionaryKey: "AppGroupId") as? String
        if let custom = customGroupId, !custom.isEmpty, !custom.contains("$") {
            appGroupId = custom
        } else {
            appGroupId = defaultGroupId
        }
    }

    private func handleLiteral(_ text: String, type: RSISharedMediaType, index: Int, content: NSExtensionItem) {
        sharedMedia.append(RSISharedMediaFile(
            path: text,
            mimeType: type == .text ? "text/plain" : nil,
            type: type
        ))
        if index == (content.attachments?.count ?? 0) - 1 {
            saveAndRedirect()
        }
    }

    private func handleUIImage(_ image: UIImage, type: RSISharedMediaType, index: Int, content: NSExtensionItem) {
        guard let containerUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId) else {
            close(); return
        }
        let tempPath = containerUrl.appendingPathComponent("TempImage.png")
        do {
            if FileManager.default.fileExists(atPath: tempPath.path) {
                try FileManager.default.removeItem(at: tempPath)
            }
            try image.pngData()?.write(to: tempPath)
            let decoded = tempPath.absoluteString.removingPercentEncoding!
            sharedMedia.append(RSISharedMediaFile(
                path: decoded,
                mimeType: "image/png",
                type: type
            ))
        } catch {
            print("Cannot write temp image: \(error)")
        }
        if index == (content.attachments?.count ?? 0) - 1 {
            saveAndRedirect()
        }
    }

    private func handleFile(_ url: URL, type: RSISharedMediaType, index: Int, content: NSExtensionItem) {
        guard let containerUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId) else {
            close(); return
        }

        let fileName = getFileName(from: url, type: type)
        let dstUrl = containerUrl.appendingPathComponent(fileName)

        if copyFile(at: url, to: dstUrl) {
            let decoded = dstUrl.absoluteString.removingPercentEncoding!
            sharedMedia.append(RSISharedMediaFile(
                path: decoded,
                mimeType: url.mimeType(),
                type: type
            ))
        }

        if index == (content.attachments?.count ?? 0) - 1 {
            saveAndRedirect()
        }
    }

    private func saveAndRedirect(message: String? = nil) {
        let userDefaults = UserDefaults(suiteName: appGroupId)
        userDefaults?.set(toData(data: sharedMedia), forKey: sharedKey)
        userDefaults?.set(message, forKey: sharedMessageKey)
        userDefaults?.synchronize()
        redirectToHostApp()
    }

    private func redirectToHostApp() {
        loadIds()
        guard let url = URL(string: "ShareMedia-\(hostAppBundleIdentifier):share") else {
            close(); return
        }

        var responder = self as UIResponder?

        if #available(iOS 18.0, *) {
            while responder != nil {
                if let application = responder as? UIApplication {
                    application.open(url, options: [:], completionHandler: nil)
                    break
                }
                responder = responder?.next
            }
        } else {
            let selectorOpenURL = sel_registerName("openURL:")
            while responder != nil {
                if (responder?.responds(to: selectorOpenURL))! {
                    _ = responder?.perform(selectorOpenURL, with: url)
                    break
                }
                responder = responder!.next
            }
        }

        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private func close() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private func getFileName(from url: URL, type: RSISharedMediaType) -> String {
        var name = url.lastPathComponent
        if name.isEmpty {
            switch type {
            case .image: name = UUID().uuidString + ".png"
            case .video: name = UUID().uuidString + ".mp4"
            case .text: name = UUID().uuidString + ".txt"
            default: name = UUID().uuidString
            }
        }
        return name
    }

    private func copyFile(at src: URL, to dst: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dst.path) {
                try FileManager.default.removeItem(at: dst)
            }
            try FileManager.default.copyItem(at: src, to: dst)
            return true
        } catch {
            print("Cannot copy \(src) to \(dst): \(error)")
            return false
        }
    }

    private func toData(data: [RSISharedMediaFile]) -> Data {
        return (try? JSONEncoder().encode(data)) ?? Data()
    }
}

// MARK: - Models matching receive_sharing_intent plugin format

class RSISharedMediaFile: Codable {
    var path: String
    var mimeType: String?
    var thumbnail: String?
    var duration: Double?
    var message: String?
    var type: RSISharedMediaType

    init(path: String, mimeType: String? = nil, thumbnail: String? = nil,
         duration: Double? = nil, message: String? = nil, type: RSISharedMediaType) {
        self.path = path
        self.mimeType = mimeType
        self.thumbnail = thumbnail
        self.duration = duration
        self.message = message
        self.type = type
    }
}

enum RSISharedMediaType: String, Codable, CaseIterable {
    case image
    case video
    case text
    case file
    case url

    var toUTTypeIdentifier: String {
        if #available(iOS 14.0, *) {
            switch self {
            case .image: return UTType.image.identifier
            case .video: return UTType.movie.identifier
            case .text: return UTType.text.identifier
            case .file: return UTType.fileURL.identifier
            case .url: return UTType.url.identifier
            }
        }
        switch self {
        case .image: return "public.image"
        case .video: return "public.movie"
        case .text: return "public.text"
        case .file: return "public.file-url"
        case .url: return "public.url"
        }
    }
}

extension URL {
    func mimeType() -> String {
        if #available(iOS 14.0, *) {
            if let mime = UTType(filenameExtension: self.pathExtension)?.preferredMIMEType {
                return mime
            }
        } else {
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension as NSString, nil)?.takeRetainedValue() {
                if let mime = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                    return mime as String
                }
            }
        }
        return "application/octet-stream"
    }
}
