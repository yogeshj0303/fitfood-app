import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));
String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    bool? error,
    List<Data>? data,
  }) {
    _error = error;
    _data = data;
  }

  FaqModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
  FaqModel copyWith({
    bool? error,
    List<Data>? data,
  }) =>
      FaqModel(
        error: error ?? _error,
        data: data ?? _data,
      );
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    num? id,
    String? question,
    String? answer,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _question = question;
    _answer = answer;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _question;
  String? _answer;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({
    num? id,
    String? question,
    String? answer,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? _id,
        question: question ?? _question,
        answer: answer ?? _answer,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
