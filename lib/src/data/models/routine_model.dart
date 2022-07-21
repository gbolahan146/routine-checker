import 'dart:convert';


class RoutineModel {
  String? description;
  String? title;
  String createdAt;
  String? updatedAt;
  String? id;
  String? time;
  String? status;
  String? frequency;

  RoutineModel({
    this.description,
    this.title,
    this.id,
    this.frequency,
    this.status,
   required this.createdAt,
    this.time,
    this.updatedAt,
  });

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
        description: map['description'],
        title: map['title'],
        createdAt: map['createdAt'],
        updatedAt: map['updatedAt'],
        time: map['time'],
        id: map['id'],
        status: map['status'],
        frequency: map['frequency']);
  }

  String toJson() => json.encode(toMap());

  factory RoutineModel.fromJson(String source) =>
      RoutineModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'time': time,
      'status':status,
      'id': id,
      'frequency': frequency
    };
  }
}
