class AirLineSeatModal {
  // Null? meta;
  List<Data>? data;

  AirLineSeatModal(
      {
      // this.meta,
      this.data});

  AirLineSeatModal.fromJson(Map<String, dynamic> json) {
    // meta = json['meta'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['meta'] = meta;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sliceId;
  List<Cabins>? cabins;
  String? segmentId;
  String? id;

  Data({this.sliceId, this.cabins, this.segmentId, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sliceId = json['slice_id'];
    if (json['cabins'] != null) {
      cabins = <Cabins>[];
      json['cabins'].forEach((v) {
        cabins!.add(Cabins.fromJson(v));
      });
    }
    segmentId = json['segment_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slice_id'] = sliceId;
    if (cabins != null) {
      data['cabins'] = cabins!.map((v) => v.toJson()).toList();
    }
    data['segment_id'] = segmentId;
    data['id'] = id;
    return data;
  }
}

class Cabins {
  Wings? wings;
  int? deck;
  int? aisles;
  String? cabinClass;
  List<Rows>? rows;

  Cabins({this.wings, this.deck, this.aisles, this.cabinClass, this.rows});

  Cabins.fromJson(Map<String, dynamic> json) {
    wings = json['wings'] != null ? Wings.fromJson(json['wings']) : null;
    deck = json['deck'];
    aisles = json['aisles'];
    cabinClass = json['cabin_class'];
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wings != null) {
      data['wings'] = wings!.toJson();
    }
    data['deck'] = deck;
    data['aisles'] = aisles;
    data['cabin_class'] = cabinClass;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wings {
  int? lastRowIndex;
  int? firstRowIndex;

  Wings({this.lastRowIndex, this.firstRowIndex});

  Wings.fromJson(Map<String, dynamic> json) {
    lastRowIndex = json['last_row_index'];
    firstRowIndex = json['first_row_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_row_index'] = lastRowIndex;
    data['first_row_index'] = firstRowIndex;
    return data;
  }
}

class Rows {
  List<Sections>? sections;
  String? id;

  Rows({this.sections, this.id});

  Rows.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Sections {
  List<Elements>? elements;
  String? id;

  Sections({this.elements, this.id});

  Sections.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(Elements.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Elements {
  bool? isSelected;
  List<String>? disclosures;
  String? designator;
  List<AvailableServices>? availableServices;
  String? type;
  dynamic? name;
  String? id;

  Elements(
      {this.disclosures,
      this.designator,
      this.availableServices,
      this.type,
      this.name,
      this.isSelected = false,
      this.id});

  Elements.fromJson(Map<String, dynamic> json) {
    if (json['disclosures'] != null) {
      disclosures = List<String>.from(json['disclosures']);
    }
    designator = json['designator'];
    designator = json['designator'];
    if (json['available_services'] != null) {
      availableServices = <AvailableServices>[];
      json['available_services'].forEach((v) {
        availableServices!.add(AvailableServices.fromJson(v));
      });
    }
    type = json['type'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disclosures'] = disclosures;
    data['designator'] = designator;
    if (availableServices != null) {
      data['available_services'] =
          availableServices!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class AvailableServices {
  String? passengerId;
  String? totalCurrency;
  String? totalAmount;
  String? id;

  AvailableServices(
      {this.passengerId, this.totalCurrency, this.totalAmount, this.id});

  AvailableServices.fromJson(Map<String, dynamic> json) {
    passengerId = json['passenger_id'];
    totalCurrency = json['total_currency'];
    totalAmount = json['total_amount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passenger_id'] = passengerId;
    data['total_currency'] = totalCurrency;
    data['total_amount'] = totalAmount;
    data['id'] = id;
    return data;
  }
}
