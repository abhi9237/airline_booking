class ErrorModal {
  List<Errors>? errors;
  Meta? meta;

  ErrorModal({this.errors, this.meta});

  ErrorModal.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Errors {
  String? documentationUrl;
  String? source;
  String? title;
  String? type;
  String? message;
  String? code;

  Errors(
      {this.documentationUrl,
      this.source,
      this.title,
      this.type,
      this.message,
      this.code});

  Errors.fromJson(Map<String, dynamic> json) {
    documentationUrl = json['documentation_url'];
    source = json['source'];
    title = json['title'];
    type = json['type'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentation_url'] = documentationUrl;
    data['source'] = source;
    data['title'] = title;
    data['type'] = type;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class Meta {
  String? requestId;
  int? status;

  Meta({this.requestId, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_id'] = requestId;
    data['status'] = status;
    return data;
  }
}
