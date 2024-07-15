class AirportSuggestionModal {
  List<dynamic>? warnings;
  dynamic meta;
  List<Data>? data;

  AirportSuggestionModal({this.data, this.warnings, this.meta});

  AirportSuggestionModal.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? cityName;
  String? icaoCode;
  String? iataCityCode;
  String? iataCountryCode;
  String? iataCode;
  double? latitude;
  double? longitude;
  String? timeZone;
  String? type;
  String? name;
  String? id;

  Data(
      {this.cityName,
      this.icaoCode,
      this.iataCityCode,
      this.iataCountryCode,
      this.iataCode,
      this.latitude,
      this.longitude,
      this.timeZone,
      this.type,
      this.name,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    icaoCode = json['icao_code'];
    iataCityCode = json['iata_city_code'];
    iataCountryCode = json['iata_country_code'];
    iataCode = json['iata_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timeZone = json['time_zone'];
    type = json['type'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_name'] = cityName;
    data['icao_code'] = icaoCode;
    data['iata_city_code'] = iataCityCode;
    data['iata_country_code'] = iataCountryCode;
    data['iata_code'] = iataCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['time_zone'] = timeZone;
    data['type'] = type;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
