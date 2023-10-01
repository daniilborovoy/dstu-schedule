import 'package:dstu_schedule/features/schedule/data/schedule_api.dart';
import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/models/schedule.dart';
import 'package:hive/hive.dart';

abstract class ScheduleService {
  factory ScheduleService() => _ScheduleService();

  Future<Schedule?> fetchScheduleAtDate(int groupId, DateTime date);

  Future<List<Group>?> fetchListOfAllGroups();

  Future<void> saveGroupId(int groupId);

  Future<void> clearSchedule();

  int? getGroupId();
}

class _ScheduleService implements ScheduleService {
  static const _scheduleApi = ScheduleApi();

  @override
  Future<List<Group>?> fetchListOfAllGroups() async {
    var groupsBox = Hive.box('groups');
    try {
      final response = await _scheduleApi.fetchListOfAllGroups();
      final List<Group> groups = response.data['data']
          .map<Group>((dynamic json) => Group.fromJson(json))
          .toList();
      await groupsBox.clear();
      await groupsBox.put('groups', groups);
      return groups;
    } catch (error) {
      final List<dynamic>? groups = groupsBox.get('groups');
      if (groups == null) {
        return [];
      }
      return groups.map<Group>((group) => group).toList();
    }
  }

  @override
  Future<Schedule?> fetchScheduleAtDate(int groupId, DateTime date) async {
    var scheduleBox = Hive.box('schedule');
    try {
      final response = await _scheduleApi.fetchScheduleAtDate(groupId, date);
      final Schedule schedule = Schedule.fromJson(response.data['data']);
      await scheduleBox.clear();
      await scheduleBox.put('schedule', schedule);
      return schedule;
    } catch (error) {
      return scheduleBox.get('schedule');
    }
  }

  @override
  Future<void> saveGroupId(int groupId) async {
    var settingsBox = Hive.box('settings');
    await settingsBox.put('group_id', groupId);
  }

  @override
  Future<void> clearSchedule() async {
    var scheduleBox = Hive.box('schedule');
    await scheduleBox.clear();
  }

  @override
  int? getGroupId() {
    var settingsBox = Hive.box('settings');
    return settingsBox.get('group_id');
  }
}
