import 'package:dstu_schedule/app.dart';
import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/services/schedule_service.dart';
import 'package:dstu_schedule/features/schedule/view/pages/schedule_page.dart';
import 'package:dstu_schedule/features/schedule/view/widgets/schedule_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupCard extends ConsumerStatefulWidget {
  final Group group;

  const GroupCard({super.key, required this.group});

  @override
  ConsumerState createState() => _GroupCardState();
}

class _GroupCardState extends ConsumerState<GroupCard> {
  bool scheduleIsLoading = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.systemFill,
      onPressed: () => _onGroupCardPressed(context),
      child: Builder(
        builder: (context) {
          if (scheduleIsLoading) {
            return const SizedBox(
              height: 64,
              child: CupertinoActivityIndicator(),
            );
          }
          return Column(
            children: [
              Text(
                widget.group.name,
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
                widget.group.faculty,
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
                widget.group.yearName,
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
          );
        },
      ),
    );
  }

  Future<void> _onGroupCardPressed(BuildContext context) async {
    final ScheduleService scheduleService = ScheduleService();
    await scheduleService.saveGroupId(widget.group.id);
    ref.read(groupIdProvider.notifier).state = widget.group.id;
    await scheduleService.clearSchedule();
    setState(() {
      scheduleIsLoading = true;
    });
    await ref.refresh(scheduleProvider.future);
    _goToSchedulePage();
    scheduleIsLoading = false;
  }

  void _goToSchedulePage() {
    Navigator.of(context).pushReplacement(SchedulePage.create(widget.group.id));
  }
}
