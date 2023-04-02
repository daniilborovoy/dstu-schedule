import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 0)
class Group extends HiveObject {
  @HiveField(0)
  final int _id;
  @HiveField(1)
  final String _name;
  @HiveField(2)
  final int _course;
  @HiveField(3)
  final String _faculty;
  @HiveField(4)
  final String _yearName;
  @HiveField(5)
  final int _facultyId;

  get id => _id;

  get name => _name;

  get course => _course;

  get faculty => _faculty;

  get yearName => _yearName;

  get facultyId => _facultyId;

  Group({
    required int id,
    required String name,
    required int course,
    required String faculty,
    required String yearName,
    required int facultyId,
  })  : _id = id,
        _name = name,
        _course = course,
        _faculty = faculty,
        _yearName = yearName,
        _facultyId = facultyId;

  Group.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _course = json['kurs'],
        _faculty = json['facul'],
        _yearName = json['yearName'],
        _facultyId = json['facultyID'];
}
