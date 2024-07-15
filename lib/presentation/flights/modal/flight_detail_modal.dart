class FlightDataModal {
  Data? data;

  FlightDataModal({this.data});

  FlightDataModal.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Offers>? offers;
  String? createdAt;
  String? cabinClass;
  bool? liveMode;
  List<Slices>? slices;
  List<Passengers>? passengers;
  String? clientKey;
  String? id;

  Data(
      {this.offers,
      this.createdAt,
      this.cabinClass,
      this.liveMode,
      this.slices,
      this.passengers,
      this.clientKey,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    cabinClass = json['cabin_class'];
    liveMode = json['live_mode'];
    if (json['slices'] != null) {
      slices = <Slices>[];
      json['slices'].forEach((v) {
        slices!.add(Slices.fromJson(v));
      });
    }
    if (json['passengers'] != null) {
      passengers = <Passengers>[];
      json['passengers'].forEach((v) {
        passengers!.add(Passengers.fromJson(v));
      });
    }
    clientKey = json['client_key'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['cabin_class'] = cabinClass;
    data['live_mode'] = liveMode;
    if (slices != null) {
      data['slices'] = slices!.map((v) => v.toJson()).toList();
    }
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    data['client_key'] = clientKey;
    data['id'] = id;
    return data;
  }
}

class Offers {
  String? totalEmissionsKg;
  List<String>? allowedPassengerIdentityDocumentTypes;
  // List<Null>? acceptedLoyaltyProgrammes;
  PaymentRequirements? paymentRequirements;
  List<String>? supportedPassengerIdentityDocumentTypes;
  bool? passengerIdentityDocumentsRequired;
  String? taxCurrency;
  String? baseCurrency;
  String? baseAmount;
  List<PrivateFares>? privateFares;
  String? taxAmount;
  String? totalCurrency;
  String? createdAt;
  bool? liveMode;
  String? totalAmount;
  List<Slices>? slices;
  List<Passengers>? passengers;
  Conditions? conditions;
  String? updatedAt;
  String? expiresAt;
  bool? partial;
  OperatingCarrier? owner;
  String? id;

  Offers(
      {this.totalEmissionsKg,
      this.allowedPassengerIdentityDocumentTypes,
      // this.acceptedLoyaltyProgrammes,
      this.paymentRequirements,
      this.supportedPassengerIdentityDocumentTypes,
      this.passengerIdentityDocumentsRequired,
      this.taxCurrency,
      this.baseCurrency,
      this.baseAmount,
      this.privateFares,
      this.taxAmount,
      this.totalCurrency,
      this.createdAt,
      this.liveMode,
      this.totalAmount,
      this.slices,
      this.passengers,
      this.conditions,
      this.updatedAt,
      this.expiresAt,
      this.partial,
      this.owner,
      this.id});

  Offers.fromJson(Map<String, dynamic> json) {
    totalEmissionsKg = json['total_emissions_kg'];
    allowedPassengerIdentityDocumentTypes =
        json['allowed_passenger_identity_document_types'].cast<String>();
    // if (json['accepted_loyalty_programmes'] != null) {
    //   acceptedLoyaltyProgrammes = <Null>[];
    //   json['accepted_loyalty_programmes'].forEach((v) {
    //     acceptedLoyaltyProgrammes!.add(Null.fromJson(v));
    //   });
    // }
    paymentRequirements = json['payment_requirements'] != null
        ? PaymentRequirements.fromJson(json['payment_requirements'])
        : null;
    supportedPassengerIdentityDocumentTypes =
        json['supported_passenger_identity_document_types'].cast<String>();
    passengerIdentityDocumentsRequired =
        json['passenger_identity_documents_required'];
    taxCurrency = json['tax_currency'];
    baseCurrency = json['base_currency'];
    baseAmount = json['base_amount'];
    if (json['private_fares'] != null) {
      privateFares = <PrivateFares>[];
      json['private_fares'].forEach((v) {
        privateFares!.add(PrivateFares.fromJson(v));
      });
    }
    taxAmount = json['tax_amount'];
    totalCurrency = json['total_currency'];
    createdAt = json['created_at'];
    liveMode = json['live_mode'];
    totalAmount = json['total_amount'];
    if (json['slices'] != null) {
      slices = <Slices>[];
      json['slices'].forEach((v) {
        slices!.add(Slices.fromJson(v));
      });
    }
    if (json['passengers'] != null) {
      passengers = <Passengers>[];
      json['passengers'].forEach((v) {
        passengers!.add(Passengers.fromJson(v));
      });
    }
    conditions = json['conditions'] != null
        ? Conditions.fromJson(json['conditions'])
        : null;
    updatedAt = json['updated_at'];
    expiresAt = json['expires_at'];
    partial = json['partial'];
    owner =
        json['owner'] != null ? OperatingCarrier.fromJson(json['owner']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_emissions_kg'] = totalEmissionsKg;
    data['allowed_passenger_identity_document_types'] =
        allowedPassengerIdentityDocumentTypes;
    // if (acceptedLoyaltyProgrammes != null) {
    //   data['accepted_loyalty_programmes'] =
    //       acceptedLoyaltyProgrammes!.map((v) => v.toJson()).toList();
    // }
    if (paymentRequirements != null) {
      data['payment_requirements'] = paymentRequirements!.toJson();
    }
    data['supported_passenger_identity_document_types'] =
        supportedPassengerIdentityDocumentTypes;
    data['passenger_identity_documents_required'] =
        passengerIdentityDocumentsRequired;
    data['tax_currency'] = taxCurrency;
    data['base_currency'] = baseCurrency;
    data['base_amount'] = baseAmount;
    if (privateFares != null) {
      data['private_fares'] = privateFares!.map((v) => v.toJson()).toList();
    }
    data['tax_amount'] = taxAmount;
    data['total_currency'] = totalCurrency;
    data['created_at'] = createdAt;
    data['live_mode'] = liveMode;
    data['total_amount'] = totalAmount;
    if (slices != null) {
      data['slices'] = slices!.map((v) => v.toJson()).toList();
    }
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    if (conditions != null) {
      data['conditions'] = conditions!.toJson();
    }
    data['updated_at'] = updatedAt;
    data['expires_at'] = expiresAt;
    data['partial'] = partial;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class PaymentRequirements {
  bool? requiresInstantPayment;
  String? priceGuaranteeExpiresAt;
  String? paymentRequiredBy;

  PaymentRequirements(
      {this.requiresInstantPayment,
      this.priceGuaranteeExpiresAt,
      this.paymentRequiredBy});

  PaymentRequirements.fromJson(Map<String, dynamic> json) {
    requiresInstantPayment = json['requires_instant_payment'];
    priceGuaranteeExpiresAt = json['price_guarantee_expires_at'];
    paymentRequiredBy = json['payment_required_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requires_instant_payment'] = requiresInstantPayment;
    data['price_guarantee_expires_at'] = priceGuaranteeExpiresAt;
    data['payment_required_by'] = paymentRequiredBy;
    return data;
  }
}

class PrivateFares {
  String? type;
  dynamic trackingReference;
  dynamic tourCode;
  dynamic corporateCode;

  PrivateFares(
      {this.type, this.trackingReference, this.tourCode, this.corporateCode});

  PrivateFares.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    trackingReference = json['tracking_reference'];
    tourCode = json['tour_code'];
    corporateCode = json['corporate_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['tracking_reference'] = trackingReference;
    data['tour_code'] = tourCode;
    data['corporate_code'] = corporateCode;
    return data;
  }
}

class Slices {
  String? comparisonKey;
  int? ngsShelf;
  String? destinationType;
  String? originType;
  String? fareBrandName;
  List<Segments>? segments;
  Conditions? conditions;
  String? duration;
  Destination? destination;
  Destination? origin;
  String? id;

  Slices(
      {this.comparisonKey,
      this.ngsShelf,
      this.destinationType,
      this.originType,
      this.fareBrandName,
      this.segments,
      this.conditions,
      this.duration,
      this.destination,
      this.origin,
      this.id});

  Slices.fromJson(Map<String, dynamic> json) {
    comparisonKey = json['comparison_key'];
    ngsShelf = json['ngs_shelf'];
    destinationType = json['destination_type'];
    originType = json['origin_type'];
    fareBrandName = json['fare_brand_name'];
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) {
        segments!.add(Segments.fromJson(v));
      });
    }
    conditions = json['conditions'] != null
        ? Conditions.fromJson(json['conditions'])
        : null;
    duration = json['duration'];
    destination = json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
    origin =
        json['origin'] != null ? Destination.fromJson(json['origin']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comparison_key'] = comparisonKey;
    data['ngs_shelf'] = ngsShelf;
    data['destination_type'] = destinationType;
    data['origin_type'] = originType;
    data['fare_brand_name'] = fareBrandName;
    if (segments != null) {
      data['segments'] = segments!.map((v) => v.toJson()).toList();
    }
    if (conditions != null) {
      data['conditions'] = conditions!.toJson();
    }
    data['duration'] = duration;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Segments {
  String? originTerminal;
  String? destinationTerminal;
  Aircraft? aircraft;
  String? departingAt;
  String? arrivingAt;
  List<Stops>? stops;
  OperatingCarrier? operatingCarrier;
  OperatingCarrier? marketingCarrier;
  String? operatingCarrierFlightNumber;
  String? marketingCarrierFlightNumber;
  String? distance;
  List<Passengers>? passengers;
  String? duration;
  Destination? destination;
  Destination? origin;
  String? id;

  Segments(
      {this.originTerminal,
      this.stops,
      this.destinationTerminal,
      this.aircraft,
      this.departingAt,
      this.arrivingAt,
      // this.stops,
      this.operatingCarrier,
      this.marketingCarrier,
      this.operatingCarrierFlightNumber,
      this.marketingCarrierFlightNumber,
      this.distance,
      this.passengers,
      this.duration,
      this.destination,
      this.origin,
      this.id});

  Segments.fromJson(Map<String, dynamic> json) {
    originTerminal = json['origin_terminal'];
    destinationTerminal = json['destination_terminal'];
    aircraft =
        json['aircraft'] != null ? Aircraft.fromJson(json['aircraft']) : null;
    departingAt = json['departing_at'];
    arrivingAt = json['arriving_at'];
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    operatingCarrier = json['operating_carrier'] != null
        ? OperatingCarrier.fromJson(json['operating_carrier'])
        : null;
    marketingCarrier = json['marketing_carrier'] != null
        ? OperatingCarrier.fromJson(json['marketing_carrier'])
        : null;
    operatingCarrierFlightNumber = json['operating_carrier_flight_number'];
    marketingCarrierFlightNumber = json['marketing_carrier_flight_number'];
    distance = json['distance'];
    if (json['passengers'] != null) {
      passengers = <Passengers>[];
      json['passengers'].forEach((v) {
        passengers!.add(Passengers.fromJson(v));
      });
    }
    duration = json['duration'];
    destination = json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
    origin =
        json['origin'] != null ? Destination.fromJson(json['origin']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['origin_terminal'] = originTerminal;
    data['destination_terminal'] = destinationTerminal;
    if (aircraft != null) {
      data['aircraft'] = aircraft!.toJson();
    }
    data['departing_at'] = departingAt;
    data['arriving_at'] = arrivingAt;
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    if (operatingCarrier != null) {
      data['operating_carrier'] = operatingCarrier!.toJson();
    }
    if (marketingCarrier != null) {
      data['marketing_carrier'] = marketingCarrier!.toJson();
    }
    data['operating_carrier_flight_number'] = operatingCarrierFlightNumber;
    data['marketing_carrier_flight_number'] = marketingCarrierFlightNumber;
    data['distance'] = distance;
    if (passengers != null) {
      data['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    data['duration'] = duration;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Stops {
  String? id;
  String? duration;
  String? departingAt;
  String? arrivingAt;
  Origin? airport;

  Stops(
      {this.id,
      this.duration,
      this.departingAt,
      this.arrivingAt,
      this.airport});

  Stops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    departingAt = json['departing_at'];
    arrivingAt = json['arriving_at'];
    airport = json['airport'] != null ? Origin.fromJson(json['airport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['departing_at'] = this.departingAt;
    data['arriving_at'] = this.arrivingAt;
    if (this.airport != null) {
      data['airport'] = this.airport!.toJson();
    }
    return data;
  }
}

class Origin {
  String? timeZone;
  String? name;
  double? longitude;
  double? latitude;
  String? id;
  String? icaoCode;
  String? iataCountryCode;
  String? iataCode;
  String? iataCityCode;
  String? cityName;
  City? city;

  Origin(
      {this.timeZone,
      this.name,
      this.longitude,
      this.latitude,
      this.id,
      this.icaoCode,
      this.iataCountryCode,
      this.iataCode,
      this.iataCityCode,
      this.cityName,
      this.city});

  Origin.fromJson(Map<String, dynamic> json) {
    timeZone = json['time_zone'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    id = json['id'];
    icaoCode = json['icao_code'];
    iataCountryCode = json['iata_country_code'];
    iataCode = json['iata_code'];
    iataCityCode = json['iata_city_code'];
    cityName = json['city_name'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['time_zone'] = this.timeZone;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['id'] = this.id;
    data['icao_code'] = this.icaoCode;
    data['iata_country_code'] = this.iataCountryCode;
    data['iata_code'] = this.iataCode;
    data['iata_city_code'] = this.iataCityCode;
    data['city_name'] = this.cityName;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Aircraft {
  String? iataCode;
  String? name;
  String? id;

  Aircraft({this.iataCode, this.name, this.id});

  Aircraft.fromJson(Map<String, dynamic> json) {
    iataCode = json['iata_code'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iata_code'] = iataCode;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class OperatingCarrier {
  String? logoSymbolUrl;
  dynamic logoLockupUrl;
  dynamic conditionsOfCarriageUrl;
  String? iataCode;
  String? name;
  String? id;

  OperatingCarrier(
      {this.logoSymbolUrl,
      this.logoLockupUrl,
      this.conditionsOfCarriageUrl,
      this.iataCode,
      this.name,
      this.id});

  OperatingCarrier.fromJson(Map<String, dynamic> json) {
    logoSymbolUrl = json['logo_symbol_url'];
    logoLockupUrl = json['logo_lockup_url'];
    conditionsOfCarriageUrl = json['conditions_of_carriage_url'];
    iataCode = json['iata_code'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo_symbol_url'] = logoSymbolUrl;
    data['logo_lockup_url'] = logoLockupUrl;
    data['conditions_of_carriage_url'] = conditionsOfCarriageUrl;
    data['iata_code'] = iataCode;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Passengers {
  Cabin? cabin;
  List<Baggages>? baggages;
  String? cabinClassMarketingName;
  String? passengerId;
  String? fareBasisCode;
  String? cabinClass;
  String? fareType;
  dynamic familyName;
  dynamic givenName;
  int? age;
  String? type;
  String? id;

  Passengers(
      {this.cabin,
      this.fareType,
      this.age,
      this.type,
      this.id,
      this.familyName,
      this.givenName,
      this.baggages,
      this.cabinClassMarketingName,
      this.passengerId,
      this.fareBasisCode,
      this.cabinClass});

  Passengers.fromJson(Map<String, dynamic> json) {
    fareType = json['fare_type'];
    familyName = json['family_name'];
    givenName = json['given_name'];
    age = json['age'];
    type = json['type'];
    id = json['id'];
    cabin = json['cabin'] != null ? Cabin.fromJson(json['cabin']) : null;
    if (json['baggages'] != null) {
      baggages = <Baggages>[];
      json['baggages'].forEach((v) {
        baggages!.add(Baggages.fromJson(v));
      });
    }
    cabinClassMarketingName = json['cabin_class_marketing_name'];
    passengerId = json['passenger_id'];
    fareBasisCode = json['fare_basis_code'];
    cabinClass = json['cabin_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cabin != null) {
      data['cabin'] = cabin!.toJson();
    }
    if (baggages != null) {
      data['baggages'] = baggages!.map((v) => v.toJson()).toList();
    }
    data['cabin_class_marketing_name'] = cabinClassMarketingName;
    data['passenger_id'] = passengerId;
    data['fare_basis_code'] = fareBasisCode;
    data['cabin_class'] = cabinClass;
    data['family_name'] = familyName;
    data['given_name'] = givenName;
    data['age'] = age;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class Cabin {
  Amenities? amenities;
  String? marketingName;
  String? name;

  Cabin({this.amenities, this.marketingName, this.name});

  Cabin.fromJson(Map<String, dynamic> json) {
    amenities = json['amenities'] != null
        ? Amenities.fromJson(json['amenities'])
        : null;
    marketingName = json['marketing_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (amenities != null) {
      data['amenities'] = amenities!.toJson();
    }
    data['marketing_name'] = marketingName;
    data['name'] = name;
    return data;
  }
}

class Amenities {
  Wifi? wifi;
  Seat? seat;
  Power? power;

  Amenities({this.wifi, this.seat, this.power});

  Amenities.fromJson(Map<String, dynamic> json) {
    wifi = json['wifi'] != null ? Wifi.fromJson(json['wifi']) : null;
    seat = json['seat'] != null ? Seat.fromJson(json['seat']) : null;
    power = json['power'] != null ? Power.fromJson(json['power']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wifi != null) {
      data['wifi'] = wifi!.toJson();
    }
    if (seat != null) {
      data['seat'] = seat!.toJson();
    }
    if (power != null) {
      data['power'] = power!.toJson();
    }
    return data;
  }
}

class Wifi {
  String? cost;
  bool? available;

  Wifi({this.cost, this.available});

  Wifi.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cost'] = cost;
    data['available'] = available;
    return data;
  }
}

class Seat {
  String? pitch;
  String? legroom;
  dynamic type;

  Seat({this.pitch, this.legroom, this.type});

  Seat.fromJson(Map<String, dynamic> json) {
    pitch = json['pitch'];
    legroom = json['legroom'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pitch'] = pitch;
    data['legroom'] = legroom;
    data['type'] = type;
    return data;
  }
}

class Power {
  bool? available;

  Power({this.available});

  Power.fromJson(Map<String, dynamic> json) {
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available'] = available;
    return data;
  }
}

class Baggages {
  int? quantity;
  String? type;

  Baggages({this.quantity, this.type});

  Baggages.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['type'] = type;
    return data;
  }
}

class Destination {
  String? cityName;
  String? icaoCode;
  String? iataCityCode;
  dynamic airports;
  String? iataCountryCode;
  String? iataCode;
  double? latitude;
  double? longitude;
  City? city;
  String? timeZone;
  String? type;
  String? name;
  String? id;

  Destination(
      {this.cityName,
      this.icaoCode,
      this.iataCityCode,
      this.airports,
      this.iataCountryCode,
      this.iataCode,
      this.latitude,
      this.longitude,
      this.city,
      this.timeZone,
      this.type,
      this.name,
      this.id});

  Destination.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    icaoCode = json['icao_code'];
    iataCityCode = json['iata_city_code'];
    airports = json['airports'];
    iataCountryCode = json['iata_country_code'];
    iataCode = json['iata_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
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
    data['airports'] = airports;
    data['iata_country_code'] = iataCountryCode;
    data['iata_code'] = iataCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['time_zone'] = timeZone;
    data['type'] = type;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class City {
  dynamic cityName;
  dynamic icaoCode;
  String? iataCityCode;
  String? iataCountryCode;
  String? iataCode;
  dynamic latitude;
  dynamic longitude;
  dynamic timeZone;
  String? type;
  String? name;
  String? id;

  City(
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

  City.fromJson(Map<String, dynamic> json) {
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

class Conditions {
  dynamic priorityCheckIn;
  dynamic priorityBoarding;
  dynamic advanceSeatSelection;
  ChangeBeforeDeparture? changeBeforeDeparture;

  Conditions(
      {this.priorityCheckIn,
      this.priorityBoarding,
      this.advanceSeatSelection,
      this.changeBeforeDeparture});

  Conditions.fromJson(Map<String, dynamic> json) {
    priorityCheckIn = json['priority_check_in'];
    priorityBoarding = json['priority_boarding'];
    advanceSeatSelection = json['advance_seat_selection'];
    changeBeforeDeparture = json['change_before_departure'] != null
        ? ChangeBeforeDeparture.fromJson(json['change_before_departure'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priority_check_in'] = priorityCheckIn;
    data['priority_boarding'] = priorityBoarding;
    data['advance_seat_selection'] = advanceSeatSelection;
    if (changeBeforeDeparture != null) {
      data['change_before_departure'] = changeBeforeDeparture!.toJson();
    }
    return data;
  }
}

class ChangeBeforeDeparture {
  dynamic penaltyCurrency;
  dynamic penaltyAmount;
  bool? allowed;

  ChangeBeforeDeparture(
      {this.penaltyCurrency, this.penaltyAmount, this.allowed});

  ChangeBeforeDeparture.fromJson(Map<String, dynamic> json) {
    penaltyCurrency = json['penalty_currency'];
    penaltyAmount = json['penalty_amount'];
    allowed = json['allowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['penalty_currency'] = penaltyCurrency;
    data['penalty_amount'] = penaltyAmount;
    data['allowed'] = allowed;
    return data;
  }
}

// class Passengers {
//   String? fareType;
//   List<Null>? loyaltyProgrammeAccounts;
//   Null? familyName;
//   Null? givenName;
//   int? age;
//   String? type;
//   String? id;
//
//   Passengers(
//       {this.fareType,
//         this.loyaltyProgrammeAccounts,
//         this.familyName,
//         this.givenName,
//         this.age,
//         this.type,
//         this.id});
//
//   Passengers.fromJson(Map<String, dynamic> json) {
//     fareType = json['fare_type'];
//     if (json['loyalty_programme_accounts'] != null) {
//       loyaltyProgrammeAccounts = <Null>[];
//       json['loyalty_programme_accounts'].forEach((v) {
//         loyaltyProgrammeAccounts!.add(Null.fromJson(v));
//       });
//     }
//     familyName = json['family_name'];
//     givenName = json['given_name'];
//     age = json['age'];
//     type = json['type'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['fare_type'] = fareType;
//     if (loyaltyProgrammeAccounts != null) {
//       data['loyalty_programme_accounts'] =
//           loyaltyProgrammeAccounts!.map((v) => v.toJson()).toList();
//     }
//     data['family_name'] = familyName;
//     data['given_name'] = givenName;
//     data['age'] = age;
//     data['type'] = type;
//     data['id'] = id;
//     return data;
//   }
// }
//
// class Conditions {
//   ChangeBeforeDeparture? refundBeforeDeparture;
//   ChangeBeforeDeparture? changeBeforeDeparture;
//
//   Conditions({this.refundBeforeDeparture, this.changeBeforeDeparture});
//
//   Conditions.fromJson(Map<String, dynamic> json) {
//     refundBeforeDeparture = json['refund_before_departure'] != null
//         ? ChangeBeforeDeparture.fromJson(json['refund_before_departure'])
//         : null;
//     changeBeforeDeparture = json['change_before_departure'] != null
//         ? ChangeBeforeDeparture.fromJson(json['change_before_departure'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (refundBeforeDeparture != null) {
//       data['refund_before_departure'] = refundBeforeDeparture!.toJson();
//     }
//     if (changeBeforeDeparture != null) {
//       data['change_before_departure'] = changeBeforeDeparture!.toJson();
//     }
//     return data;
//   }
// }
//
// class Slices {
//   String? destinationType;
//   String? originType;
//   String? departureDate;
//   Destination? destination;
//   Destination? origin;
//
//   Slices(
//       {this.destinationType,
//         this.originType,
//         this.departureDate,
//         this.destination,
//         this.origin});
//
//   Slices.fromJson(Map<String, dynamic> json) {
//     destinationType = json['destination_type'];
//     originType = json['origin_type'];
//     departureDate = json['departure_date'];
//     destination = json['destination'] != null
//         ? Destination.fromJson(json['destination'])
//         : null;
//     origin = json['origin'] != null
//         ? Destination.fromJson(json['origin'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['destination_type'] = destinationType;
//     data['origin_type'] = originType;
//     data['departure_date'] = departureDate;
//     if (destination != null) {
//       data['destination'] = destination!.toJson();
//     }
//     if (origin != null) {
//       data['origin'] = origin!.toJson();
//     }
//     return data;
//   }
// }
//
// class Destination {
//   String? cityName;
//   String? icaoCode;
//   String? iataCityCode;
//   List<Airports>? airports;
//   String? iataCountryCode;
//   String? iataCode;
//   double? latitude;
//   double? longitude;
//   City? city;
//   String? timeZone;
//   String? type;
//   String? name;
//   String? id;
//
//   Destination(
//       {this.cityName,
//         this.icaoCode,
//         this.iataCityCode,
//         this.airports,
//         this.iataCountryCode,
//         this.iataCode,
//         this.latitude,
//         this.longitude,
//         this.city,
//         this.timeZone,
//         this.type,
//         this.name,
//         this.id});
//
//   Destination.fromJson(Map<String, dynamic> json) {
//     cityName = json['city_name'];
//     icaoCode = json['icao_code'];
//     iataCityCode = json['iata_city_code'];
//     if (json['airports'] != null) {
//       airports = <Airports>[];
//       json['airports'].forEach((v) {
//         airports!.add(Airports.fromJson(v));
//       });
//     }
//     iataCountryCode = json['iata_country_code'];
//     iataCode = json['iata_code'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     city = json['city'] != null ? City.fromJson(json['city']) : null;
//     timeZone = json['time_zone'];
//     type = json['type'];
//     name = json['name'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['city_name'] = cityName;
//     data['icao_code'] = icaoCode;
//     data['iata_city_code'] = iataCityCode;
//     if (airports != null) {
//       data['airports'] = airports!.map((v) => v.toJson()).toList();
//     }
//     data['iata_country_code'] = iataCountryCode;
//     data['iata_code'] = iataCode;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     if (city != null) {
//       data['city'] = city!.toJson();
//     }
//     data['time_zone'] = timeZone;
//     data['type'] = type;
//     data['name'] = name;
//     data['id'] = id;
//     return data;
//   }
// }

class Airports {
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

  Airports(
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

  Airports.fromJson(Map<String, dynamic> json) {
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
