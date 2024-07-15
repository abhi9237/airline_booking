class BookingDetailModal {
  Data? data;

  BookingDetailModal({this.data});

  BookingDetailModal.fromJson(Map<String, dynamic> json) {
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
  List<Documents>? documents;
  String? syncedAt;
  List<String>? availableActions;
  List<dynamic>? airlineInitiatedChanges;
  dynamic? cancellation;
  String? taxCurrency;
  String? baseCurrency;
  String? baseAmount;
  String? taxAmount;
  String? totalCurrency;
  String? offerId;
  String? bookingReference;
  String? createdAt;
  PaymentStatus? paymentStatus;
  bool? liveMode;
  String? totalAmount;
  List<Slices>? slices;
  List<Passengers>? passengers;
  Conditions? conditions;
  dynamic cancelledAt;
  // List<Null>? changes;
  String? content;
  // List<Null>? services;
  // List<Null>? users;
  dynamic? metadata;
  String? type;
  OperatingCarrier? owner;
  String? id;

  Data(
      {this.documents,
      this.syncedAt,
      this.availableActions,
      this.airlineInitiatedChanges,
      this.cancellation,
      this.taxCurrency,
      this.baseCurrency,
      this.baseAmount,
      this.taxAmount,
      this.totalCurrency,
      this.offerId,
      this.bookingReference,
      this.createdAt,
      this.paymentStatus,
      this.liveMode,
      this.totalAmount,
      this.slices,
      this.passengers,
      this.conditions,
      this.cancelledAt,
      // this.changes,
      this.content,
      // this.services,
      // this.users,
      this.metadata,
      this.type,
      this.owner,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
    syncedAt = json['synced_at'];
    availableActions = json['available_actions'].cast<String>();
    // if (json['airline_initiated_changes'] != null) {
    //   airlineInitiatedChanges = <Null>[];
    //   json['airline_initiated_changes'].forEach((v) {
    //     airlineInitiatedChanges!.add(Null.fromJson(v));
    //   });
    // }
    cancellation = json['cancellation'];
    taxCurrency = json['tax_currency'];
    baseCurrency = json['base_currency'];
    baseAmount = json['base_amount'];
    taxAmount = json['tax_amount'];
    totalCurrency = json['total_currency'];
    offerId = json['offer_id'];
    bookingReference = json['booking_reference'];
    createdAt = json['created_at'];
    paymentStatus = json['payment_status'] != null
        ? PaymentStatus.fromJson(json['payment_status'])
        : null;
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
    cancelledAt = json['cancelled_at'];
    // if (json['changes'] != null) {
    //   changes = <Null>[];
    //   json['changes'].forEach((v) {
    //     changes!.add(Null.fromJson(v));
    //   });
    // }
    content = json['content'];
    // if (json['services'] != null) {
    //   services = <Null>[];
    //   json['services'].forEach((v) {
    //     services!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['users'] != null) {
    //   users = <Null>[];
    //   json['users'].forEach((v) {
    //     users!.add(Null.fromJson(v));
    //   });
    // }
    metadata = json['metadata'];
    type = json['type'];
    owner =
        json['owner'] != null ? OperatingCarrier.fromJson(json['owner']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    data['synced_at'] = syncedAt;
    data['available_actions'] = availableActions;
    if (airlineInitiatedChanges != null) {
      data['airline_initiated_changes'] =
          airlineInitiatedChanges!.map((v) => v.toJson()).toList();
    }
    data['cancellation'] = cancellation;
    data['tax_currency'] = taxCurrency;
    data['base_currency'] = baseCurrency;
    data['base_amount'] = baseAmount;
    data['tax_amount'] = taxAmount;
    data['total_currency'] = totalCurrency;
    data['offer_id'] = offerId;
    data['booking_reference'] = bookingReference;
    data['created_at'] = createdAt;
    if (paymentStatus != null) {
      data['payment_status'] = paymentStatus!.toJson();
    }
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
    data['cancelled_at'] = cancelledAt;
    // if (this.changes != null) {
    //   data['changes'] = this.changes!.map((v) => v.toJson()).toList();
    // }
    data['content'] = content;
    // if (this.services != null) {
    //   data['services'] = this.services!.map((v) => v.toJson()).toList();
    // }
    // if (this.users != null) {
    //   data['users'] = this.users!.map((v) => v.toJson()).toList();
    // }
    data['metadata'] = metadata;
    data['type'] = type;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Documents {
  List<String>? passengerIds;
  String? uniqueIdentifier;
  String? type;

  Documents({this.passengerIds, this.uniqueIdentifier, this.type});

  Documents.fromJson(Map<String, dynamic> json) {
    passengerIds = json['passenger_ids'].cast<String>();
    uniqueIdentifier = json['unique_identifier'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passenger_ids'] = passengerIds;
    data['unique_identifier'] = uniqueIdentifier;
    data['type'] = type;
    return data;
  }
}

class PaymentStatus {
  String? paidAt;
  dynamic? priceGuaranteeExpiresAt;
  dynamic? paymentRequiredBy;
  bool? awaitingPayment;

  PaymentStatus(
      {this.paidAt,
      this.priceGuaranteeExpiresAt,
      this.paymentRequiredBy,
      this.awaitingPayment});

  PaymentStatus.fromJson(Map<String, dynamic> json) {
    paidAt = json['paid_at'];
    priceGuaranteeExpiresAt = json['price_guarantee_expires_at'];
    paymentRequiredBy = json['payment_required_by'];
    awaitingPayment = json['awaiting_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paid_at'] = paidAt;
    data['price_guarantee_expires_at'] = priceGuaranteeExpiresAt;
    data['payment_required_by'] = paymentRequiredBy;
    data['awaiting_payment'] = awaitingPayment;
    return data;
  }
}

class Slices {
  bool? changeable;
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
      {this.changeable,
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
    changeable = json['changeable'];
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
    data['changeable'] = changeable;
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
  OperatingCarrier? operatingCarrier;
  OperatingCarrier? marketingCarrier;
  String? departureTerminal;
  String? arrivalTerminal;
  String? operatingCarrierFlightNumber;
  String? marketingCarrierFlightNumber;
  String? arrivalDatetime;
  String? departureDatetime;
  String? distance;
  List<Passengers>? passengers;
  String? duration;
  Destination? destination;
  Destination? origin;
  String? id;

  Segments(
      {this.originTerminal,
      this.destinationTerminal,
      this.aircraft,
      this.departingAt,
      this.arrivingAt,
      this.operatingCarrier,
      this.marketingCarrier,
      this.departureTerminal,
      this.arrivalTerminal,
      this.operatingCarrierFlightNumber,
      this.marketingCarrierFlightNumber,
      this.arrivalDatetime,
      this.departureDatetime,
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
    operatingCarrier = json['operating_carrier'] != null
        ? OperatingCarrier.fromJson(json['operating_carrier'])
        : null;
    marketingCarrier = json['marketing_carrier'] != null
        ? OperatingCarrier.fromJson(json['marketing_carrier'])
        : null;
    departureTerminal = json['departure_terminal'];
    arrivalTerminal = json['arrival_terminal'];
    operatingCarrierFlightNumber = json['operating_carrier_flight_number'];
    marketingCarrierFlightNumber = json['marketing_carrier_flight_number'];
    arrivalDatetime = json['arrival_datetime'];
    departureDatetime = json['departure_datetime'];
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
    if (operatingCarrier != null) {
      data['operating_carrier'] = operatingCarrier!.toJson();
    }
    if (marketingCarrier != null) {
      data['marketing_carrier'] = marketingCarrier!.toJson();
    }
    data['departure_terminal'] = departureTerminal;
    data['arrival_terminal'] = arrivalTerminal;
    data['operating_carrier_flight_number'] = operatingCarrierFlightNumber;
    data['marketing_carrier_flight_number'] = marketingCarrierFlightNumber;
    data['arrival_datetime'] = arrivalDatetime;
    data['departure_datetime'] = departureDatetime;
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
  dynamic? logoLockupUrl;
  dynamic? conditionsOfCarriageUrl;
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

// class Passengers {
//   List<Baggages>? baggages;
//   String? cabinClassMarketingName;
//   String? passengerId;
//   Null? seat;
//   String? cabinClass;
//
//   Passengers(
//       {this.baggages,
//       this.cabinClassMarketingName,
//       this.passengerId,
//       this.seat,
//       this.cabinClass});
//
//   Passengers.fromJson(Map<String, dynamic> json) {
//     if (json['baggages'] != null) {
//       baggages = <Baggages>[];
//       json['baggages'].forEach((v) {
//         baggages!.add(Baggages.fromJson(v));
//       });
//     }
//     cabinClassMarketingName = json['cabin_class_marketing_name'];
//     passengerId = json['passenger_id'];
//     seat = json['seat'];
//     cabinClass = json['cabin_class'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (baggages != null) {
//       data['baggages'] = baggages!.map((v) => v.toJson()).toList();
//     }
//     data['cabin_class_marketing_name'] = cabinClassMarketingName;
//     data['passenger_id'] = passengerId;
//     data['seat'] = seat;
//     data['cabin_class'] = cabinClass;
//     return data;
//   }
// }

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
  String? icaoCode;
  String? iataCountryCode;
  String? iataCode;
  String? iataCityCode;
  String? cityName;
  double? latitude;
  double? longitude;
  dynamic? city;
  String? timeZone;
  String? type;
  String? name;
  String? id;

  Destination(
      {this.icaoCode,
      this.iataCountryCode,
      this.iataCode,
      this.iataCityCode,
      this.cityName,
      this.latitude,
      this.longitude,
      this.city,
      this.timeZone,
      this.type,
      this.name,
      this.id});

  Destination.fromJson(Map<String, dynamic> json) {
    icaoCode = json['icao_code'];
    iataCountryCode = json['iata_country_code'];
    iataCode = json['iata_code'];
    iataCityCode = json['iata_city_code'];
    cityName = json['city_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    timeZone = json['time_zone'];
    type = json['type'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icao_code'] = icaoCode;
    data['iata_country_code'] = iataCountryCode;
    data['iata_code'] = iataCode;
    data['iata_city_code'] = iataCityCode;
    data['city_name'] = cityName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city'] = city;
    data['time_zone'] = timeZone;
    data['type'] = type;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Conditions {
  ChangeBeforeDeparture? changeBeforeDeparture;

  Conditions({this.changeBeforeDeparture});

  Conditions.fromJson(Map<String, dynamic> json) {
    changeBeforeDeparture = json['change_before_departure'] != null
        ? ChangeBeforeDeparture.fromJson(json['change_before_departure'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (changeBeforeDeparture != null) {
      data['change_before_departure'] = changeBeforeDeparture!.toJson();
    }
    return data;
  }
}

class ChangeBeforeDeparture {
  dynamic? penaltyCurrency;
  dynamic? penaltyAmount;
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

class Passengers {
  String? bornOn;
  // List<Null>? loyaltyProgrammeAccounts;
  dynamic? infantPassengerId;
  String? familyName;
  String? givenName;
  String? gender;
  String? phoneNumber;
  dynamic? userId;
  String? email;
  String? title;
  String? type;
  String? id;

  Passengers(
      {this.bornOn,
      // this.loyaltyProgrammeAccounts,
      this.infantPassengerId,
      this.familyName,
      this.givenName,
      this.gender,
      this.phoneNumber,
      this.userId,
      this.email,
      this.title,
      this.type,
      this.id});

  Passengers.fromJson(Map<String, dynamic> json) {
    bornOn = json['born_on'];
    // if (json['loyalty_programme_accounts'] != null) {
    //   loyaltyProgrammeAccounts = <Null>[];
    //   json['loyalty_programme_accounts'].forEach((v) {
    //     loyaltyProgrammeAccounts!.add(new Null.fromJson(v));
    //   });
    // }
    infantPassengerId = json['infant_passenger_id'];
    familyName = json['family_name'];
    givenName = json['given_name'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    userId = json['user_id'];
    email = json['email'];
    title = json['title'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['born_on'] = this.bornOn;
    // if (this.loyaltyProgrammeAccounts != null) {
    //   data['loyalty_programme_accounts'] =
    //       this.loyaltyProgrammeAccounts!.map((v) => v.toJson()).toList();
    // }
    data['infant_passenger_id'] = this.infantPassengerId;
    data['family_name'] = this.familyName;
    data['given_name'] = this.givenName;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['title'] = this.title;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}

// class Conditions {
//   RefundBeforeDeparture? refundBeforeDeparture;
//   ChangeBeforeDeparture? changeBeforeDeparture;
//
//   Conditions({this.refundBeforeDeparture, this.changeBeforeDeparture});
//
//   Conditions.fromJson(Map<String, dynamic> json) {
//     refundBeforeDeparture = json['refund_before_departure'] != null
//         ? new RefundBeforeDeparture.fromJson(json['refund_before_departure'])
//         : null;
//     changeBeforeDeparture = json['change_before_departure'] != null
//         ? new ChangeBeforeDeparture.fromJson(json['change_before_departure'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.refundBeforeDeparture != null) {
//       data['refund_before_departure'] = this.refundBeforeDeparture!.toJson();
//     }
//     if (this.changeBeforeDeparture != null) {
//       data['change_before_departure'] = this.changeBeforeDeparture!.toJson();
//     }
//     return data;
//   }
// }

class RefundBeforeDeparture {
  String? penaltyCurrency;
  String? penaltyAmount;
  bool? allowed;

  RefundBeforeDeparture(
      {this.penaltyCurrency, this.penaltyAmount, this.allowed});

  RefundBeforeDeparture.fromJson(Map<String, dynamic> json) {
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

class ServicesModal {
  int? quantity;
  String? id;
  ServicesModal({this.id, this.quantity});

  factory ServicesModal.fromJson(Map<String, dynamic> json) {
    return ServicesModal(id: json['id'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }
}
