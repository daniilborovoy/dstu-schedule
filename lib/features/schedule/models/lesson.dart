import 'package:hive/hive.dart';

part 'lesson.g.dart';

@HiveType(typeId: 4)
class Lesson {
  @HiveField(0)
  int id;
  @HiveField(1)
  String discipline;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  DateTime startTime;
  @HiveField(4)
  DateTime endTime;
  @HiveField(5)
  String teacher;
  @HiveField(6)
  String auditory;

  Lesson({
    required this.id,
    required this.discipline,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.teacher,
    required this.auditory,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['код'],
      discipline: json['дисциплина'],
      date: DateTime.parse(json['дата']),
      startTime: DateTime.parse(json['датаНачала']),
      endTime: DateTime.parse(json['датаОкончания']),
      teacher: json['преподаватель'],
      auditory: json['аудитория'],
    );
  }
}
