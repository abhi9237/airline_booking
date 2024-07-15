class PassengerModal {
  String? type;
  String? title;
  String? id;
  String? givenName;
  String? gender;
  String? familyName;
  String? email;
  String? bornOn;
  String? mobileNo;
  List<IdentityDocuments>? identityDocuments;
  PassengerModal(
      {this.givenName,
      this.id,
      this.type,
      this.familyName,
      this.title,
      this.email,
      this.bornOn,
      this.gender,
      this.mobileNo,
      this.identityDocuments});

  factory PassengerModal.fromJson(Map<String, dynamic> json) {
    return PassengerModal(
      title: json['title'],
      type: json['type'],
      id: json['id'],
      givenName: json['given_name'],
      gender: json['gender'],
      familyName: json['family_name'],
      email: json['email'],
      bornOn: json['born_on'],
      mobileNo: json['phone_number'],
      identityDocuments: (json['identity_documents'] as List<dynamic>?)
          ?.map((item) => IdentityDocuments.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['given_name'] = givenName;
    data['gender'] = gender;
    data['family_name'] = familyName;
    data['email'] = email;
    data['born_on'] = bornOn;
    data['type'] = type;
    data['phone_number'] = mobileNo;
    if (identityDocuments != null) {
      data['identity_documents'] = identityDocuments!
          .map((identityDoc) => identityDoc.toJson())
          .toList();
    }
    return data;
  }
}

class IdentityDocuments {
  String? passportNo;
  String? type;
  String? countryCode;
  String? expireOn;
  IdentityDocuments(
      {this.passportNo, this.type, this.countryCode, this.expireOn});
  factory IdentityDocuments.fromJson(Map<String, dynamic> json) {
    return IdentityDocuments(
      passportNo: json['unique_identifier'],
      type: json['type'],
      countryCode: json['issuing_country_code'],
      expireOn: json['expires_on'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['expires_on'] = expireOn;
    data['issuing_country_code'] = countryCode;
    data['type'] = type;
    data['unique_identifier'] = passportNo;
    return data;
  }
}

class Payments {
  String? type;
  String? currency;
  String? amount;
  Payments({this.type, this.amount, this.currency});

  factory Payments.fromJson(Map<String, dynamic> json) {
    return Payments(
      type: json['type'],
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}

class TitleModal {
  String? name;
  String? title;
  TitleModal({this.title, this.name});
}

class GenderModal {
  String? name;
  String? title;
  GenderModal({this.title, this.name});
}
