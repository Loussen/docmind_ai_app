# DoCMind AI — App Store Privacy Guide (v1.1.2)

This document reflects the **actual** data collection in the app. There is **no login, register, email, or name** collection in the shipped app. Users are identified by a **device ID** only.

---

## What the app actually collects

| Data | Collected? | Where | Tracking? |
|------|------------|-------|-----------|
| Email / Name / Password | **No** | Not in app UI | — |
| Device ID (UUID / IDFV) | **Yes** | Backend + TikTok SDK | TikTok: Yes |
| Device model & OS version | **Yes** | Backend only | No |
| Uploaded documents (PDF, DOC, images) | **Yes** | Backend (AI processing) | **No** |
| Generated summaries | **Yes** | Backend | No |
| Subscription status (IAP) | **Yes** | Apple StoreKit + backend | TikTok events: Yes |
| App usage events | **Yes** | TikTok SDK (metadata only) | Yes |
| IDFA (Advertising Identifier) | **Optional** | TikTok, only if user allows ATT | Yes |

**TikTok does NOT receive document text.** It receives device ID, purchase/subscription events, and anonymous interaction metadata (e.g. `document_uploaded`, screen views).

---

## App Store Connect — App Privacy (step by step)

### Step 1: Data Collection — check these boxes only

**Do NOT check:** Contact Info, Health & Fitness, Location, Financial Info, Browsing History, Search History, Contacts, Sensitive Info, Photos or Videos (separate), Audio

**DO check:**

| Category | Type |
|----------|------|
| **Identifiers** | Device ID |
| **User Content** | Other User Content |
| **Purchases** | Purchase History |
| **Usage Data** | Product Interaction |

---

### Step 2: Configure each data type

#### Device ID
- **Purposes:** App Functionality, Analytics, Third-Party Advertising
- **Linked to identity:** Yes
- **Used for tracking:** **Yes**

#### Other User Content (documents & summaries)
- **Purposes:** App Functionality **only**
- **Linked to identity:** Yes (tied to device ID on server)
- **Used for tracking:** **No**
- **Do NOT select:** Third-Party Advertising, Analytics for tracking

#### Purchase History
- **Purposes:** App Functionality, Analytics
- **Linked to identity:** Yes
- **Used for tracking:** **Yes** (TikTok conversion events)

#### Product Interaction
- **Purposes:** Analytics, Third-Party Advertising
- **Linked to identity:** No (or Yes if TikTok links — either is acceptable)
- **Used for tracking:** **Yes**

---

### Step 3: Expected Privacy Label preview

**Data Used to Track You**
- Identifiers → Device ID
- Purchases → Purchase History
- Usage Data → Product Interaction

**Data Linked to You**
- Identifiers → Device ID
- User Content → Other User Content
- Purchases → Purchase History

**NOT shown:** Email, Name, Phone, Contact Info

---

## Other App Store Connect tasks

### Privacy Policy URL
`https://docsmind.app/privacy` — must match the updated policy (device-based, no accounts, TikTok disclosure).

### App Review Information → Notes
```
DoCMind AI has no user accounts, login, or registration. Users are identified 
by an anonymous device ID generated on first launch.

Core flow: upload PDF/DOC/image → AI summary. No chat feature despite app name branding.

Delete data: Settings → Delete Account (removes all documents, summaries, and 
usage data for this device via DELETE /api/device/data).

Subscriptions: Pro and Pro+ auto-renewable. Legal terms and "Manage in App Store" 
link are shown on the subscription screen.

ATT: App requests tracking permission for TikTok ad measurement (optional for user).
```

### Subscription (Guideline 3.1.2)
Already in app: auto-renewal text, Terms/Privacy links, Manage in App Store link, StoreKit prices only.

### Delete Account (Guideline 5.1.1)
Settings → Delete Account calls backend to delete all device data. Works without login.

---

## Before submitting build

1. Deploy Laravel API (`DELETE /api/device/data`) to production
2. Deploy updated privacy policy to `docsmind.app/privacy`
3. Publish App Privacy labels in App Store Connect (above)
4. Build: `flutter build ipa --release` (when ready)

---

## Common rejection risks (current status)

| Risk | Status |
|------|--------|
| Missing delete data option | Fixed in Settings |
| Privacy labels don't match app | Fix in Connect (this guide) |
| Privacy policy mentions email/login | Fixed on website |
| Other User Content marked as tracking | Fix in Connect |
| Subscription legal disclosure | Fixed in app |
| Debug network keys in Info.plist | Fixed |
| Misleading "chat" in description | Update description, keep name if desired |
