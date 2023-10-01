import 'package:dstu_schedule/features/schedule/view/widgets/schedule_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  late DateRangePickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DateRangePickerController();
  }

  @override
  Widget build(BuildContext context) {
    final schedule = ref.read(scheduleProvider);
    return schedule.when(
      data: (schedule) {
        return SafeArea(
          top: false,
          child: Container(
            height: 316,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
            child: SafeArea(
              top: false,
              child: SfDateRangePicker(
                onSelectionChanged: onDateSelectionChanged,
                controller: _controller,
                cellBuilder:
                    (BuildContext context, DateRangePickerCellDetails details) {
                  final isToday = details.visibleDates.contains(DateTime.now());
                  final isWorkDay = schedule?.schedule
                          .where((element) => element.date == details.date)
                          .isNotEmpty ??
                      false;
                  final textColor = isToday
                      ? CupertinoTheme.of(context).primaryContrastingColor
                      : isWorkDay
                          ? CupertinoTheme.of(context).primaryColor
                          : CupertinoColors.systemGrey;
                  return ClipOval(
                    child: Center(
                      child: Text(
                        details.date.day.toString(),
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                  );
                },
                selectionShape: DateRangePickerSelectionShape.circle,
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedDate: ref.read(selectedDateProvider),
                view: DateRangePickerView.month,
                monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderHeight: 50,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    backgroundColor:
                        CupertinoTheme.of(context).barBackgroundColor,
                    textStyle: TextStyle(
                      color: CupertinoTheme.of(context).primaryColor,
                    ),
                  ),
                ),
                backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
                headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor:
                      CupertinoTheme.of(context).barBackgroundColor,
                  textStyle: TextStyle(
                    color: CupertinoTheme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Container();
      },
      loading: () {
        return const CupertinoActivityIndicator();
      },
    );
  }

  void onDateSelectionChanged(dateRangePickerSelectionChangedArgs) {
    ref.read(selectedDateProvider.notifier).state =
        dateRangePickerSelectionChangedArgs.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
