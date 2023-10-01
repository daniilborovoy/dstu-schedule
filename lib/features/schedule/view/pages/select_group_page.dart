import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/services/schedule_service.dart';
import 'package:dstu_schedule/features/schedule/view/widgets/groups_list.dart';
import 'package:dstu_schedule/features/schedule/view/widgets/search_group_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchInputProvider = StateProvider((ref) => '');

final groupsProvider = FutureProvider((ref) async {
  final scheduleService = ScheduleService();
  final groups = await scheduleService.fetchListOfAllGroups();
  return groups;
});

final filteredGroupsProvider = Provider<List<Group>>((ref) {
  final groups = ref.watch(groupsProvider);
  final searchInput = ref.watch(searchInputProvider.select((value) => value));
  return groups.when(
    data: (groups) {
      if (searchInput.isEmpty) {
        return groups ?? [];
      }
      return groups
              ?.where((group) =>
                  group.name.toLowerCase().contains(searchInput.toLowerCase()))
              .toList() ??
          [];
    },
    loading: () => [],
    error: (error, stackTrace) => [],
  );
});

class SelectGroupPage extends ConsumerWidget {
  const SelectGroupPage({super.key});

  static create() {
    return CupertinoPageRoute(builder: (context) {
      return const SelectGroupPage();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsProvider);
    final filteredGroups = ref.watch(filteredGroupsProvider);

    return groups.when(
      data: (groups) {
        return SafeArea(
          child: CupertinoPageScaffold(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
              child: Column(
                children: [
                  const Text(
                    'Выберите группу',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const SearchGroupInput(),
                  const SizedBox(height: 16.0),
                  const Divider(
                    color: CupertinoColors.lightBackgroundGray,
                    height: 0,
                  ),
                  GroupsList(filteredGroups),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Ошибка'));
      },
      loading: () {
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }
}
