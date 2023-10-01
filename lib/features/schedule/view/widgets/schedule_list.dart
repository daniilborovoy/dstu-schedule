import 'package:dstu_schedule/features/schedule/models/lesson.dart';
import 'package:dstu_schedule/features/schedule/models/schedule.dart';
import 'package:dstu_schedule/features/schedule/services/schedule_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final scheduleProvider = FutureProvider((ref) async {
  final ScheduleService scheduleService = ScheduleService();
  int? groupId = scheduleService.getGroupId();
  if (groupId == null) {
    throw Exception('Group id is null. Maybe you need to select group first?');
  }
  final DateTime selectedDate =
      ref.watch(selectedDateProvider) ?? DateTime.now();
  final schedule =
      await scheduleService.fetchScheduleAtDate(groupId, selectedDate);
  return schedule;
});

class ScheduleList extends ConsumerStatefulWidget {
  const ScheduleList({super.key});

  @override
  ConsumerState createState() => _ScheduleListState();
}

class _ScheduleListState extends ConsumerState<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    final schedule = ref.watch(scheduleProvider);
    return schedule.when(
      data: (schedule) {
        if (schedule == null) {
          return const Center(
            child: Text('Расписание не найдено'),
          );
        }
        return WeekDayList(schedule: schedule);
      },
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/space.svg',
                width: 300,
                height: 300,
              ),
              const Text('Что-то пошло не так'),
              CupertinoButton(
                onPressed: onUpdatePressed,
                child: const Text('Обновить'),
              ),
            ],
          ),
        );
      },
      loading: () {
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }

  void onUpdatePressed() {
    ref.invalidate(scheduleProvider);
  }
}

class WeekDayList extends ConsumerStatefulWidget {
  final Schedule _schedule;

  static const List<String> weekDays = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье'
  ];

  const WeekDayList({super.key, required Schedule schedule})
      : _schedule = schedule;

  @override
  ConsumerState createState() => _WeekDayList();
}

class Week {
  late final DateTime _currentDate;
  late final int weekDayIndex;

  static const List<String> weekDaysNames = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье'
  ];

  Map<int, String> weekDayPerDate = {};

  Week({DateTime? date}) {
    _currentDate = date ?? DateTime.now();
    weekDayIndex = _getWeekDayIndex();
    final firstWeekDayDate =
        _currentDate.subtract(Duration(days: _currentDate.weekday - 1));
    for (int i = 0; i < weekDaysNames.length; i++) {
      final date = firstWeekDayDate.add(Duration(days: i));
      final year = date.year;
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');
      weekDayPerDate[i] = '$day.$month.$year';
    }
  }

  _getWeekDayIndex() {
    return _currentDate.weekday - 1;
  }

  getWeekDayDateStringByIndex(int index) {
    return weekDayPerDate[index];
  }
}

class _WeekDayList extends ConsumerState<WeekDayList>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Week week;

  @override
  void initState() {
    super.initState();
    final seletedDate = ref.read(selectedDateProvider);
    week = Week(date: seletedDate);
    _tabController = TabController(
      length: WeekDayList.weekDays.length,
      vsync: this,
      initialIndex: week.weekDayIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CupertinoColors.black,
      child: TabBarView(controller: _tabController, children: [
        for (int i = 0; i < WeekDayList.weekDays.length; i++)
          CupertinoTabView(
            builder: (context) {
              final schedule = widget._schedule;
              final List<Lesson> lessons = schedule.schedule
                  .where((element) => element.date.weekday == i + 1)
                  .toList();
              const String assetName = 'assets/cat.svg';
              final titleText = WeekDayList.weekDays[i];
              if (lessons.isEmpty) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(titleText),
                        Text(week.getWeekDayDateStringByIndex(i),
                            style: const TextStyle(fontSize: 12))
                      ],
                    ),
                  ),
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(assetName, width: 200, height: 200),
                      Text(
                        'Нет пар. Гуляем!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CupertinoTheme.of(context)
                              .textTheme
                              .textStyle
                              .color,
                        ),
                      ),
                    ],
                  )),
                );
              }
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(titleText),
                      Text(week.getWeekDayDateStringByIndex(i),
                          style: const TextStyle(fontSize: 12))
                    ],
                  ),
                ),
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final Lesson lesson = lessons[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.discipline,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    _formatTime(lesson.startTime),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const Text(' - ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: CupertinoColors
                                              .lightBackgroundGray)),
                                  Text(
                                    _formatTime(lesson.endTime),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: CupertinoColors.white,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                lesson.teacher,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                lesson.auditory,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
      ]),
    );
  }

  _formatTime(DateTime time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
