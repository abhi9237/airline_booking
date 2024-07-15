class SelectChildrenAge {
  int? age;
  SelectChildrenAge({this.age});
}

class ClassModal {
  bool? isSelected;
  String? text;
  String? type;
  ClassModal({this.text, this.isSelected, this.type});
}

class PassengerModal {
  String? type;
  int? age;
  // String? fareType;
  PassengerModal({
    this.type,
    this.age,
    // this.fareType
  });

  factory PassengerModal.fromJson(Map<String, dynamic> json) {
    return PassengerModal(
      type: json['type'],
      age: json['age'] != null ? int.parse(json['age']) : null,
      // fareType: json['fare_type']
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['age'] = age;
    // data['fare_type'] = fareType;
    return data;
  }
}

class Slices {
  String? origin;
  String? destination;
  String? departDate;
  Slices({this.origin, this.destination, this.departDate});

  factory Slices.fromJson(Map<String, dynamic> json) {
    return Slices(
      departDate: json['departure_date'],
      destination: json['destination'],
      origin: json['origin'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['departure_date'] = departDate;
    data['destination'] = destination;
    data['origin'] = origin;
    return data;
  }
}
