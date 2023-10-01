import 'package:dstu_schedule/features/schedule/data/groups_api.dart';
import 'package:dstu_schedule/features/schedule/models/group.dart';

abstract class GroupsService {
  factory GroupsService() => _GroupsService();

  Future<Group> getGroupInfo(int groupId);
}

class _GroupsService implements GroupsService {
  static const _groupsApi = GroupsApi();

  @override
  Future<Group> getGroupInfo(int groupId) async {
    final response = await _groupsApi.fetchGroupInfo(groupId);
    return Group.fromJson(response.data!['data']);
  }
}
