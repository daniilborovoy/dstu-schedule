import 'package:dstu_schedule/features/schedule/view/widgets/go_settings_button.dart';
import 'package:dstu_schedule/features/schedule/view/widgets/open_calendar_button.dart';
import 'package:dstu_schedule/features/schedule/view/widgets/schedule_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  static create(int groupId) {
    return CupertinoPageRoute(builder: (context) {
      return const SchedulePage();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Расписание'),
        transitionBetweenRoutes: false,
        previousPageTitle: 'Группы',
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            GoToSettingsButton(),
            OpenCalendarButton(),
          ],
        ),
      ),
      child: const SafeArea(
        child: ScheduleList(),
      ),
    );
  }
}
