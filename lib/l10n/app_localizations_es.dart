// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'DoCMind AI';

  @override
  String get appTagline => 'OCR, documentos y resumen con IA';

  @override
  String get navHome => 'Inicio';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get addDocument => 'Añadir documento';

  @override
  String get optionDocument => 'Documento';

  @override
  String get optionDocumentSub => 'PDF, Word u otros archivos';

  @override
  String get optionGallery => 'Galería';

  @override
  String get optionGallerySub => 'Elegir de la biblioteca de fotos';

  @override
  String get optionCamera => 'Cámara';

  @override
  String get optionCameraSub => 'Tomar una foto';

  @override
  String get greeting => 'Hola';

  @override
  String get planPro => 'Pro';

  @override
  String get planProPlus => 'Pro+';

  @override
  String get planFree => 'Gratis';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get recentDocuments => 'Documentos recientes';

  @override
  String get upload => 'Subir';

  @override
  String get uploadFormats => 'PDF, DOCX, Imagen';

  @override
  String get history => 'Historial';

  @override
  String get viewAllDocs => 'Ver todos los documentos';

  @override
  String get seeAll => 'Ver todo';

  @override
  String get noDocumentsYet => 'Aún no hay documentos';

  @override
  String get uploadFirstDoc =>
      'Sube tu primer documento y deja que la IA lo resuma por ti';

  @override
  String get uploadDocument => 'Subir documento';

  @override
  String get premiumActive => 'Premium activo';

  @override
  String get unlimitedDocsSummaries => 'Documentos y resúmenes ilimitados';

  @override
  String get freePlan => 'Plan gratuito';

  @override
  String get noFreeDocsLeft => 'No quedan documentos gratis';

  @override
  String freeLeftCount(int count) {
    return '$count restantes';
  }

  @override
  String get upgradeForUnlimited => 'Actualiza para acceso ilimitado';

  @override
  String freeDocsUsed(int used, int limit) {
    return '$used de $limit documentos gratis usados';
  }

  @override
  String get upgrade => 'Actualizar';

  @override
  String get failed => 'Error';

  @override
  String minAgo(int count) {
    return 'hace $count min';
  }

  @override
  String hoursAgo(int count) {
    return 'hace ${count}h';
  }

  @override
  String get yesterday => 'Ayer';

  @override
  String daysAgo(int count) {
    return 'hace $count días';
  }

  @override
  String get clearFilters => 'Borrar filtros';

  @override
  String get documentDeleted => 'Documento eliminado';

  @override
  String get noDocumentsFiltered => 'No se encontraron documentos';

  @override
  String get tryRemovingFilters =>
      'Prueba a quitar los filtros o subir\nnuevos documentos';

  @override
  String get clearFiltersButton => 'Borrar filtros';

  @override
  String get deleteDocument => 'Eliminar documento';

  @override
  String get deleteDocumentConfirm =>
      '¿Estás seguro de que quieres eliminar este documento?';

  @override
  String get deleteDocumentConfirmFull =>
      '¿Estás seguro de que quieres eliminar este documento? Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get allDocuments => 'Todos los documentos';

  @override
  String get pdfOnly => 'Solo PDF';

  @override
  String get wordOnly => 'Solo Word';

  @override
  String get imagesOnly => 'Solo imágenes';

  @override
  String get settings => 'Ajustes';

  @override
  String get proMember => 'Miembro Pro';

  @override
  String get proPlusMember => 'Miembro Pro+';

  @override
  String get unlimitedAccess => 'Acceso ilimitado';

  @override
  String get upgradeForMoreFeatures => 'Actualiza para más funciones';

  @override
  String get preferences => 'Preferencias';

  @override
  String get support => 'Soporte';

  @override
  String get account => 'Cuenta';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get appLanguage => 'Idioma de la app';

  @override
  String get summaryLanguage => 'Idioma del resumen';

  @override
  String get helpFaq => 'Ayuda y preguntas frecuentes';

  @override
  String get rateApp => 'Valorar app';

  @override
  String get rateAppSub => '¿Te gusta DoCMind AI? ¡Valóranos!';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirm =>
      '¿Estás seguro de que quieres eliminar tu cuenta? Esta acción no se puede deshacer.';

  @override
  String get deleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String appVersion(String version) {
    return 'DoCMind AI v$version';
  }

  @override
  String whatsNew(String version) {
    return 'Novedades de la v$version';
  }

  @override
  String get ok => 'OK';

  @override
  String get document => 'Documento';

  @override
  String get failedToLoadDocument => 'Error al cargar el documento';

  @override
  String get tryAgain => 'Reintentar';

  @override
  String get documentNotFound => 'Documento no encontrado';

  @override
  String get loadingPdf => 'Cargando PDF...';

  @override
  String get loadingPreview => 'Cargando vista previa del documento...';

  @override
  String showingPage(int count) {
    return 'Página 1 de $count';
  }

  @override
  String get documentContent => 'Contenido del documento';

  @override
  String get noContentExtracted => 'Aún no se ha extraído contenido';

  @override
  String get previewNotAvailable => 'Vista previa no disponible';

  @override
  String get viewSummary => 'Ver resumen';

  @override
  String get generating => 'Generando...';

  @override
  String get generateAiSummary => 'Generar resumen con IA';

  @override
  String pagesCount(int count) {
    return '$count páginas';
  }

  @override
  String get uploadDocumentTitle => 'Subir documento';

  @override
  String get tipReading => 'La IA está leyendo tu documento...';

  @override
  String get tipExtracting => 'Extrayendo información clave...';

  @override
  String get tipIdentifying => 'Identificando secciones importantes...';

  @override
  String get tipBuilding => 'Creando un resumen estructurado...';

  @override
  String get tipFinalizing => 'Casi listo, finalizando resultados...';

  @override
  String get stepUploading => 'Subiendo';

  @override
  String get stepExtractingText => 'Extrayendo texto';

  @override
  String get stepAiAnalyzing => 'Análisis IA';

  @override
  String get summaryLang => 'Idioma del resumen';

  @override
  String uploadingProgress(int percent) {
    return 'Subiendo tu documento... $percent%';
  }

  @override
  String get extractingText => 'Extrayendo texto de tu documento...';

  @override
  String get aiAnalyzing => 'La IA está analizando y resumiendo...';

  @override
  String get preparing => 'Preparando...';

  @override
  String get tapToUpload => 'Toca para subir un documento';

  @override
  String supportedFormats(int size) {
    return 'PDF, DOCX, JPG, PNG hasta $size MB';
  }

  @override
  String get aiWillExtract => 'La IA extraerá y resumirá el contenido';

  @override
  String get freeLimitReached =>
      'Límite gratuito alcanzado. Actualiza para continuar';

  @override
  String get readyToProcess => 'Listo para procesar';

  @override
  String get chooseDifferentFile => 'Elegir otro archivo';

  @override
  String get selectedFile => 'Archivo seleccionado';

  @override
  String get generateSummary => 'Generar resumen';

  @override
  String freePlanFileLimit(int size) {
    return 'Límite del plan gratuito: máx. $size MB por archivo. Actualiza para subir documentos más grandes.';
  }

  @override
  String fileSizeExceeded(int size) {
    return 'El tamaño del archivo supera el límite de tu plan (máx. $size MB). Actualiza para archivos más grandes.';
  }

  @override
  String get freeLimitReachedTitle => 'Límite gratuito alcanzado';

  @override
  String get freeLimitReachedMsg =>
      'Has usado todos tus documentos gratis. ¡Actualiza a Pro para acceso ilimitado!';

  @override
  String get maybeLater => 'Quizás más tarde';

  @override
  String get upgradeNow => 'Actualizar ahora';

  @override
  String get summary => 'Resumen';

  @override
  String get failedToLoadSummary => 'Error al cargar el resumen';

  @override
  String get summaryNotFound => 'Resumen no encontrado';

  @override
  String get overview => 'Resumen general';

  @override
  String get keyPoints => 'Puntos clave';

  @override
  String get actionItems => 'Acciones pendientes';

  @override
  String get keywords => 'Palabras clave';

  @override
  String get importantFacts => 'Datos importantes';

  @override
  String get obligations => 'Obligaciones';

  @override
  String get risks => 'Riesgos';

  @override
  String get findings => 'Hallazgos';

  @override
  String wordsCount(int count) {
    return '$count palabras';
  }

  @override
  String processingTime(String seconds) {
    return '${seconds}s';
  }

  @override
  String get viewOriginalDocument => 'Ver documento original';

  @override
  String get copySummary => 'Copiar resumen';

  @override
  String get summaryCopied => 'Resumen copiado al portapapeles';

  @override
  String get generatedBy => 'Generado por DoCMind AI';

  @override
  String wordCountLabel(int count) {
    return 'Palabras: $count';
  }

  @override
  String processingTimeLabel(String seconds) {
    return 'Tiempo de procesamiento: ${seconds}s';
  }

  @override
  String get upgradeRequired => 'Actualización requerida';

  @override
  String get translateProOnly =>
      'La traducción está disponible en planes Pro. Actualiza para traducir resúmenes.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get manageSubscription => 'Gestionar suscripción';

  @override
  String get changeYourPlan => 'Cambiar tu plan';

  @override
  String get unlockPremium => 'Desbloquear Premium';

  @override
  String get upgradeOrSwitch => 'Actualiza o cambia a otro plan';

  @override
  String get getUnlimitedAccess =>
      'Obtén acceso ilimitado a todas las funciones';

  @override
  String get monthly => 'Mensual';

  @override
  String get yearly => 'Anual';

  @override
  String get save40 => 'AHORRA 40 %';

  @override
  String get unlimitedDocuments => 'Documentos ilimitados';

  @override
  String get unlimitedSummaries => 'Resúmenes ilimitados';

  @override
  String get priorityAiProcessing => 'Procesamiento IA prioritario';

  @override
  String get exportToPdf => 'Exportar a PDF';

  @override
  String get emailSupport => 'Soporte por email';

  @override
  String get everythingInPro => 'Todo lo de Pro';

  @override
  String get ocrScannedDocs => 'OCR para documentos escaneados';

  @override
  String get longDocSupport => 'Documentos largos (100+ páginas)';

  @override
  String get advancedAiAnalysis => 'Análisis IA avanzado';

  @override
  String get prioritySupport => 'Soporte prioritario';

  @override
  String get earlyAccess => 'Acceso anticipado a funciones';

  @override
  String get freePlanInfo =>
      'El plan gratuito incluye 2 documentos de hasta 5 páginas cada uno.';

  @override
  String get restoring => 'Restaurando...';

  @override
  String get current => 'ACTUAL';

  @override
  String get popular => 'POPULAR';

  @override
  String get perYear => '/año';

  @override
  String get perMonth => '/mes';

  @override
  String get billedAnnually => 'Facturación anual';

  @override
  String thatsOnly(String price) {
    return 'Solo $price/mes';
  }

  @override
  String get getPro => 'Obtener Pro';

  @override
  String get getProPlus => 'Obtener Pro+';

  @override
  String get currentPlan => 'Plan actual';

  @override
  String get switchToYearly => 'Cambiar a anual';

  @override
  String get switchToMonthly => 'Cambiar a mensual';

  @override
  String get upgradeToPro => 'Actualizar a Pro';

  @override
  String get upgradeToProPlus => 'Actualizar a Pro+';

  @override
  String get downgradeToPro => 'Bajar a Pro';

  @override
  String get downgradeToProPlus => 'Bajar a Pro+';

  @override
  String get changesAtEnd => 'Los cambios al final del período de facturación';

  @override
  String autoRenews(String date) {
    return 'Se renueva automáticamente el $date';
  }

  @override
  String expires(String date) {
    return 'Expira el $date';
  }

  @override
  String get soon => 'pronto';

  @override
  String get active => 'ACTIVO';

  @override
  String get downgradePlan => 'Bajar de plan';

  @override
  String get downgradeConfirm =>
      'Tu plan se reducirá al final del período de facturación actual. Mantendrás tus funciones actuales hasta entonces.';

  @override
  String get confirmDowngrade => 'Confirmar bajada';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get signInContinue => 'Inicia sesión para continuar en DoCMind AI';

  @override
  String get createAccountToStart => 'Crea tu cuenta para empezar';

  @override
  String get emailAddress => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get enterEmail => 'Por favor, introduce tu email';

  @override
  String get validEmail => 'Por favor, introduce un email válido';

  @override
  String get enterPassword => 'Por favor, introduce tu contraseña';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get orContinueWith => 'o continuar con';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get tryWithoutAccount => 'Probar sin cuenta';

  @override
  String get noAccount => '¿No tienes cuenta? ';

  @override
  String get haveAccount => '¿Ya tienes cuenta? ';

  @override
  String get signUp => 'Registrarse';

  @override
  String get tryDoCMindAi => 'Probar DoCMind AI';

  @override
  String trialsLeft(int count) {
    return '$count prueba(s) restante(s)';
  }

  @override
  String get noTrialsRemaining => 'No quedan pruebas';

  @override
  String get summarizeNow => 'Resumir ahora';

  @override
  String get analyzingDocument => 'Analizando tu documento...';

  @override
  String get thisMayTakeAMoment => 'Esto puede tardar un momento';

  @override
  String get guestModeLimitations => 'Limitaciones del modo invitado';

  @override
  String get maxPagesGuest => 'Máx. 2 páginas por documento';

  @override
  String get twoTrialsOnly => 'Solo 2 pruebas en total (sin reinicio)';

  @override
  String get notSavedToHistory => 'Resumen no guardado en el historial';

  @override
  String get noCloudSync => 'Sin sincronización en la nube';

  @override
  String get withFreeAccount => 'Con una cuenta gratuita obtienes:';

  @override
  String get upToFivePages => 'Hasta 5 páginas por documento';

  @override
  String get threeDocsPerDay => '3 documentos al día';

  @override
  String get historySavedForever => 'Historial guardado para siempre';

  @override
  String get cloudSyncDevices =>
      'Sincronización en la nube en todos los dispositivos';

  @override
  String get wantUnlimitedAccess => '¿Quieres acceso ilimitado?';

  @override
  String get createFreeForMore => 'Crea una cuenta gratuita para más funciones';

  @override
  String get createFreeAccount => 'Crear cuenta gratuita';

  @override
  String get selectDocSource => 'Seleccionar fuente del documento';

  @override
  String get browseFiles => 'Explorar archivos';

  @override
  String get pdfWordDocs => 'PDF, documentos Word';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get captureDocCamera => 'Capturar documento con la cámara';

  @override
  String get photoLibrary => 'Biblioteca de fotos';

  @override
  String get selectFromGallery => 'Seleccionar de la galería';

  @override
  String get fileTooLargeGuest =>
      'Archivo demasiado grande. Máximo 5 MB en modo invitado.';

  @override
  String get failedPickFile => 'Error al seleccionar archivo';

  @override
  String get failedCapturePhoto => 'Error al capturar foto';

  @override
  String get failedPickImage => 'Error al seleccionar imagen';

  @override
  String get trialLimitReached => 'Límite de pruebas alcanzado';

  @override
  String get trialLimitMsg =>
      'Has usado todas tus pruebas gratuitas. Crea una cuenta para seguir usando DoCMind AI con acceso ilimitado.';

  @override
  String get noSummaryAvailable => 'No hay resumen disponible';

  @override
  String get summaryNotSaved =>
      'Este resumen no se guardará. ¡Crea una cuenta para conservarlo!';

  @override
  String get documentSummary => 'Resumen del documento';

  @override
  String get noOverviewAvailable => 'No hay resumen general disponible';

  @override
  String moreKeyPoints(int count) {
    return '$count puntos clave más';
  }

  @override
  String itemsCount(int count) {
    return '$count elementos';
  }

  @override
  String get createFreeToUnlock => 'Crea una cuenta gratuita para desbloquear';

  @override
  String trialsRemaining(int count) {
    return '$count prueba(s) restante(s)';
  }

  @override
  String get createAccountContinue =>
      'Crea una cuenta para seguir usando DoCMind AI';

  @override
  String get createAccountUnlimited =>
      'Crea una cuenta para resúmenes ilimitados';

  @override
  String get close => 'Cerrar';

  @override
  String get processingFailed =>
      'Error al procesar el documento. Por favor, inténtalo de nuevo.';

  @override
  String get processingTakingLong =>
      'El procesamiento está tardando más de lo esperado. Consulta el historial para ver el estado.';

  @override
  String get translating => 'Traduciendo';

  @override
  String get aiTranslatingYourSummary => 'La IA está traduciendo tu resumen';

  @override
  String get translationComplete => 'Traducción completada';

  @override
  String translatedTo(String language) {
    return 'Traducido a $language';
  }

  @override
  String originalLanguage(String language) {
    return 'Original: $language';
  }

  @override
  String generatedOn(String date) {
    return 'Generado el $date';
  }

  @override
  String get pleaseWait => 'Por favor espere';

  @override
  String get updateRequired => 'Actualización necesaria';

  @override
  String get updateRequiredMsg =>
      'Hay una nueva versión de DoCMind AI disponible. Actualiza para seguir usando la aplicación.';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get onboardingUploadTitle => 'Sube documentos';

  @override
  String get onboardingUploadDesc =>
      'Sube tus PDF, DOCX o imágenes y deja que la IA haga el resto. Obtén resúmenes en segundos.';

  @override
  String get onboardingSummaryTitle => 'Resúmenes con IA';

  @override
  String get onboardingSummaryDesc =>
      'Obtén al instante puntos clave, tareas y datos importantes de cualquier documento.';

  @override
  String get onboardingTranslateTitle => 'Traduce resúmenes';

  @override
  String get onboardingTranslateDesc =>
      'Traduce tus resúmenes a más de 13 idiomas con un solo toque.';

  @override
  String get onboardingShareTitle => 'Comparte desde cualquier app';

  @override
  String get onboardingShareDesc =>
      'Envía archivos directamente desde WhatsApp, Telegram o cualquier app para obtener resúmenes instantáneos.';

  @override
  String get onboardingHistoryTitle => 'Historial y filtros';

  @override
  String get onboardingHistoryDesc =>
      'Todos tus documentos organizados en un solo lugar. Filtra por PDF, Word o imágenes.';

  @override
  String get onboardingCopyShareTitle => 'Copiar y Compartir';

  @override
  String get onboardingCopyShareDesc =>
      'Copia tus resúmenes al portapapeles o compártelos a través de tus aplicaciones favoritas.';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingGetStarted => 'Empezar';
}
