class Country {
  String? phoneCode;
  String? countryCode;
  int? e164Sc;
  bool? geographic;
  int? level;
  String? name;
  String? nameLocalized;
  String? example;
  String? displayName;
  String? fullExampleWithPlusSign;
  String? displayNameNoCountryCode;
  String? e164Key;
  int? phoneNumberLength;

  Country({
    this.phoneCode,
    this.countryCode,
    this.e164Sc,
    this.geographic,
    this.level,
    this.name,
    this.nameLocalized,
    this.example,
    this.displayName,
    this.fullExampleWithPlusSign,
    this.displayNameNoCountryCode,
    this.e164Key,
    this.phoneNumberLength,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
        phoneCode: map['e164_cc'],
        countryCode: map['iso2_cc'],
        e164Sc: map['e164_sc'],
        geographic: map['geographic'],
        level: map['level'],
        name: map['name'],
        nameLocalized: map['nameLocalized'],
        example: map['example'],
        displayName: map['display_name'],
        fullExampleWithPlusSign: map['full_example_with_plus_sign'],
        displayNameNoCountryCode: map['display_name_no_e164_cc'],
        e164Key: map['e164_key'],
        phoneNumberLength: map['phone_length']);
  }

  Map<String, dynamic> toMap() {
    return {
      'phone_length': phoneNumberLength,
      'e164_cc': phoneCode,
      'iso2_cc': countryCode,
      'e164_sc': e164Sc,
      'geographic': geographic,
      'level': level,
      'name': name,
      'nameLocalized': nameLocalized,
      'example': example,
      'display_name': displayName,
      'full_example_with_plus_sign': fullExampleWithPlusSign,
      'display_name_no_e164_cc': displayNameNoCountryCode,
      'e164_key': e164Key,
    };
  }
}
