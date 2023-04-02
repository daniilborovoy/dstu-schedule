import 'package:dstu_schedule/app.dart';
import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/services/groups_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupsServiceProvider = Provider((ref) => GroupsService());

final userGroupInfoProvider = FutureProvider.autoDispose((ref) {
  final groupId = ref.watch(groupIdProvider);
  final groupsService = ref.watch(groupsServiceProvider);
  if (groupId == null) {
    throw Exception("Group id not found. Please select group first");
  }
  return groupsService.getGroupInfo(groupId);
});

class UserGroupInfo extends ConsumerWidget {
  const UserGroupInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsInfo = ref.watch(userGroupInfoProvider);
    return groupsInfo.when(
      data: (Group group) {
        return SizedBox(
          height: 100,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    group.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${group.course} курс',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text('Ошибка получения информации о группе'),
        );
      },
      loading: () {
        return const SizedBox(
          height: 100,
          child: Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
