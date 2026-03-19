class LanguageOption {
  final String code; // BCP-47-ish (en, fr, zh-Hans, zh-Hant)
  final String name;
  final String flag; // emoji flag

  const LanguageOption(this.code, this.name, this.flag);
}

const appUiLanguages = <LanguageOption>[
  LanguageOption('en', 'English', '🇬🇧'),
  LanguageOption('nl', 'Dutch', '🇳🇱'),
  LanguageOption('fr', 'French', '🇫🇷'),
  LanguageOption('de', 'German', '🇩🇪'),
  LanguageOption('id', 'Indonesian', '🇮🇩'),
  LanguageOption('it', 'Italian', '🇮🇹'),
  LanguageOption('ja', 'Japanese', '🇯🇵'),
  LanguageOption('pt', 'Portuguese', '🇵🇹'),
  LanguageOption('ru', 'Russian', '🇷🇺'),
  LanguageOption('zh-Hans', 'Chinese (Simplified)', '🇨🇳'),
  LanguageOption('es', 'Spanish', '🇪🇸'),
  LanguageOption('zh-Hant', 'Chinese (Traditional)', '🇹🇼'),
  LanguageOption('tr', 'Turkish', '🇹🇷'),
];

const outputLanguages = <LanguageOption>[
  LanguageOption('en', 'English', '🇬🇧'),
  LanguageOption('es', 'Spanish', '🇪🇸'),
  LanguageOption('fr', 'French', '🇫🇷'),
  LanguageOption('de', 'German', '🇩🇪'),
  LanguageOption('it', 'Italian', '🇮🇹'),
  LanguageOption('pt', 'Portuguese', '🇵🇹'),
  LanguageOption('ru', 'Russian', '🇷🇺'),
  LanguageOption('tr', 'Turkish', '🇹🇷'),
  LanguageOption('ja', 'Japanese', '🇯🇵'),
  LanguageOption('zh-Hans', 'Chinese (Simplified)', '🇨🇳'),
  LanguageOption('zh-Hant', 'Chinese (Traditional)', '🇹🇼'),
  LanguageOption('nl', 'Dutch', '🇳🇱'),
  LanguageOption('id', 'Indonesian', '🇮🇩'),
];

String languageName(String code, {bool forUi = false}) {
  final list = forUi ? appUiLanguages : outputLanguages;
  return list.firstWhere((l) => l.code == code, orElse: () => LanguageOption(code, code, '🏳️')).name;
}

String languageFlag(String code, {bool forUi = false}) {
  final list = forUi ? appUiLanguages : outputLanguages;
  return list.firstWhere((l) => l.code == code, orElse: () => LanguageOption(code, code, '🏳️')).flag;
}

