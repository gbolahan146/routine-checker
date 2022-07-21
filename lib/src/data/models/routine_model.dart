import 'dart:convert';

class RoutineModel {
  String? description;
  String? title;
  String createdAt;
  String? updatedAt;
  String? routineId;
  String? time;
  String? status;
  String? frequency;

  RoutineModel({
    this.description,
    this.title,
    this.routineId,
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
        routineId: map['routineId'],
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
      'status': status,
      'routineId': routineId,
      'frequency': frequency
    };
  }
}
