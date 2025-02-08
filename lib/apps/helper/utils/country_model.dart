class CountryModel {
  final String name;
  final String dialCode;
  final String code;
  final int mobileNumberLength;
  final String format;

  CountryModel({
    required this.name,
    required this.dialCode,
    required this.code,
    required this.mobileNumberLength,
    required this.format,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code;

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}
