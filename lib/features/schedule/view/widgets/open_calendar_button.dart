import 'package:dstu_schedule/features/schedule/view/widgets/calendar.dart';
import 'package:flutter/cupertino.dart';

class OpenCalendarButton extends StatelessWidget {
  const OpenCalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => showCalendarInPopup(context),
      child: const Icon(
        CupertinoIcons.calendar,
        size: 22.0,
      ),
    );
  }

  void showCalendarInPopup(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return const Calendar();
      },
    );
  }
}
