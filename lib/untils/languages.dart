part of untils;

class Languages {
  Languages._();
  static const vi = Locale('vi', 'VN');
  static const en = Locale('en', 'US');
  static final localizations = const <Locale>[
    Locale('vi', 'VN'),
    Locale('en', 'US'),
  ];
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return 'πΊπΈ';
      case 'vi':
        return 'π»π³';
      default:
        return 'π»π³';
    }
  }
}
