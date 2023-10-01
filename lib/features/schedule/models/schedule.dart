import 'package:dstu_schedule/features/schedule/models/lesson.dart';
import 'package:hive/hive.dart';

part 'schedule.g.dart';

@HiveType(typeId: 1)
class Schedule {
  @HiveField(0)
  final bool _isCyclicalSchedule;
  @HiveField(1)
  final List<Lesson> _schedule;
  @HiveField(2)
  final ScheduleInfo _scheduleInfo;

  get isCyclicalSchedule => _isCyclicalSchedule;

  List<Lesson> get schedule => _schedule;

  ScheduleInfo get scheduleInfo => _scheduleInfo;

  Schedule({
    required bool isCyclicalSchedule,
    required List<Lesson> schedule,
    required ScheduleInfo scheduleInfo,
  })  : _isCyclicalSchedule = isCyclicalSchedule,
        _schedule = schedule,
        _scheduleInfo = scheduleInfo;

  Schedule.fromJson(Map<String, dynamic> json)
      : _isCyclicalSchedule = json['isCyclicalSchedule'],
        _schedule = json['rasp']
            .map<Lesson>((dynamic json) => Lesson.fromJson(json))
            .toList(),
        _scheduleInfo = ScheduleInfo.fromJson(json['info']);

  Schedule.fromHashMap(dynamic hashMap)
      : _isCyclicalSchedule = hashMap['isCyclicalSchedule'],
        _schedule = hashMap['rasp'].map<Lesson>((lesson) => lesson).toList(),
        _scheduleInfo = ScheduleInfo.fromJson(hashMap['info']);
}

@HiveType(typeId: 2)
class ScheduleInfo {
  @HiveField(0)
  final ScheduleGroup _group;
  @HiveField(1)
  final ScheduleTeacher _teacher;
  @HiveField(2)
  final ScheduleAuditory _auditory;
  @HiveField(3)
  final String _year;
  @HiveField(4)
  final int _weekNumber;
  @HiveField(5)
  final int _semesterNumber;
  @HiveField(6)
  final DateTime _date;
  @HiveField(7)
  final DateTime _lastDate;
  @HiveField(8)
  final DateTime _uploadDateTime;

  ScheduleGroup get group => _group;

  ScheduleTeacher get teacher => _teacher;

  ScheduleAuditory get auditory => _auditory;

  get year => _year;

  get weekNumber => _weekNumber;

  get semesterNumber => _semesterNumber;

  get date => _date;

  get lastDate => _lastDate;

  get uploadDateTime => _uploadDateTime;

  ScheduleInfo({
    required ScheduleGroup group,
    required ScheduleTeacher teacher,
    required ScheduleAuditory auditory,
    required String year,
    required int weekNumber,
    required int semesterNumber,
    required DateTime date,
    required DateTime lastDate,
    required DateTime uploadDateTime,
  })  : _group = group,
        _teacher = teacher,
        _auditory = auditory,
        _year = year,
        _weekNumber = weekNumber,
        _semesterNumber = semesterNumber,
        _date = date,
        _lastDate = lastDate,
        _uploadDateTime = uploadDateTime;

  ScheduleInfo.fromJson(Map<String, dynamic> json)
      : _group = ScheduleGroup.fromJson(json['group']),
        _teacher = ScheduleTeacher.fromJson(json['prepod']),
        _auditory = ScheduleAuditory.fromJson(json['aud']),
        _year = json['year'],
        _weekNumber = json['curWeekNumber'],
        _semesterNumber = json['curSem'],
        _date = DateTime.parse(json['date']),
        _lastDate = DateTime.parse(json['lastDate']),
        _uploadDateTime = DateTime.parse(json['dateUploadingRasp']);
}

@HiveType(typeId: 3)
class ScheduleGroup {
  @HiveField(0)
  final String _name;
  @HiveField(1)
  final int _groupId;

  get name => _name;

  get groupId => _groupId;

  ScheduleGroup({
    required String name,
    required int groupId,
  })  : _name = name,
        _groupId = groupId;

  ScheduleGroup.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _groupId = json['groupID'];
}

@HiveType(typeId: 5)
class ScheduleTeacher {
  @HiveField(0)
  final String _name;

  get name => _name;

  ScheduleTeacher({
    required String name,
  }) : _name = name;

  ScheduleTeacher.fromJson(Map<String, dynamic> json) : _name = json['name'];
}

@HiveType(typeId: 6)
class ScheduleAuditory {
  @HiveField(0)
  final String _name;

  get name => _name;

  ScheduleAuditory({
    required String name,
  }) : _name = name;

  ScheduleAuditory.fromJson(Map<String, dynamic> json) : _name = json['name'];
}
