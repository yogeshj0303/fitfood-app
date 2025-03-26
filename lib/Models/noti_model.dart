import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));
String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    bool? error,
    List<Message>? message,
  }) {
    _error = error;
    _message = message;
  }

  NotificationModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message?.add(Message.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Message>? _message;
  NotificationModel copyWith({
    bool? error,
    List<Message>? message,
  }) =>
      NotificationModel(
        error: error ?? _error,
        message: message ?? _message,
      );
  bool? get error => _error;
  List<Message>? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_message != null) {
      map['message'] = _message?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    num? id,
    String? adminId,
    String? date,
    String? time,
    String? type,
    String? message,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _adminId = adminId;
    _date = date;
    _time = time;
    _type = type;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Message.fromJson(dynamic json) {
    _id = json['id'];
    _adminId = json['admin_id'];
    _date = json['date'];
    _time = json['time'];
    _type = json['type'];
    _message = json['message'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _adminId;
  String? _date;
  String? _time;
  String? _type;
  String? _message;
  String? _createdAt;
  String? _updatedAt;
  Message copyWith({
    num? id,
    String? adminId,
    String? date,
    String? time,
    String? type,
    String? message,
    String? createdAt,
    String? updatedAt,
  }) =>
      Message(
        id: id ?? _id,
        adminId: adminId ?? _adminId,
        date: date ?? _date,
        time: time ?? _time,
        type: type ?? _type,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get adminId => _adminId;
  String? get date => _date;
  String? get time => _time;
  String? get type => _type;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['admin_id'] = _adminId;
    map['date'] = _date;
    map['time'] = _time;
    map['type'] = _type;
    map['message'] = _message;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
