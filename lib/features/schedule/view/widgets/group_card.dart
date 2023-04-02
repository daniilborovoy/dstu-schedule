import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/services/schedule_service.dart';
import 'package:dstu_schedule/features/schedule/view/pages/schedule_page.dart';
import 'package:flutter/cupertino.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.systemFill,
      onPressed: () => onGroupCardPressed(context),
      child: Column(
        children: [
          Text(
            group.name,
            style: TextStyle(
              fontSize: 20,
              color: CupertinoTheme.of(context)
                  .textTheme
                  .textStyle
                  .color
                  ?.withOpacity(0.8),
            ),
          ),
          Text(
            group.faculty,
            style: TextStyle(
              fontSize: 15,
              color: CupertinoTheme.of(context)
                  .textTheme
                  .textStyle
                  .color
                  ?.withOpacity(0.6),
            ),
          ),
          Text(
            group.yearName,
            style: TextStyle(
              fontSize: 15,
              color: CupertinoTheme.of(context)
                  .textTheme
                  .textStyle
                  .color
                  ?.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  void onGroupCardPressed(BuildContext context) {
    final ScheduleService scheduleService = ScheduleService();
    scheduleService.saveGroupId(group.id).then((value) {
      scheduleService.clearSchedule().then((value) {
        Navigator.of(context).pushReplacement(
          SchedulePage.create(group.id),
        );
      });
    });
  }
}
