import 'package:dstu_schedule/app.dart';
import 'package:dstu_schedule/features/schedule/models/group.dart';
import 'package:dstu_schedule/features/schedule/models/lesson.dart';
import 'package:dstu_schedule/features/schedule/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await dotenv.load();
  await setupHiveStore();
  runApp(const ProviderScope(child: App()));
}

Future<void> setupHiveStore() async {
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  // register adapters
  Hive
    ..registerAdapter(GroupAdapter())
    ..registerAdapter(ScheduleAdapter())
    ..registerAdapter(LessonAdapter())
    ..registerAdapter(ScheduleInfoAdapter())
    ..registerAdapter(ScheduleGroupAdapter())
    ..registerAdapter(ScheduleTeacherAdapter())
    ..registerAdapter(ScheduleAuditoryAdapter());
  // open boxes
  await Hive.openBox('settings');
  await Hive.openBox('schedule');
  await Hive.openBox('groups');
}
