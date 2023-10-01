import 'package:dstu_schedule/features/schedule/view/pages/schedule_page.dart';
import 'package:dstu_schedule/features/schedule/view/pages/select_group_page.dart';
import 'package:dstu_schedule/features/settings/services/preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final groupIdProvider = StateProvider((ref) {
  var box = Hive.box('settings');
  return box.get('group_id') as int?;
});

class ThemeNotifier extends ChangeNotifier {
  late String _theme;
  Color _primaryColor = Colors.blueGrey;

  ThemeNotifier() {
    var box = Hive.box('settings');
    _theme = box.get('theme') as String? ?? 'light';
    _primaryColor = PreferencesService().getPrimaryColor();
    notifyListeners();
  }

  String get theme => _theme;

  set theme(String value) {
    _theme = value;
    var box = Hive.box('settings');
    box.put('theme', value);
    notifyListeners();
  }

  Color get primaryColor => _primaryColor;

  set primaryColor(Color color) {
    _primaryColor = color;
    final preferencesService = PreferencesService();
    preferencesService.setPrimaryColor(color);
    notifyListeners();
  }
}

final themeProvider = ChangeNotifierProvider<ThemeNotifier>(
  (ref) => ThemeNotifier(),
);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupId = ref.read(groupIdProvider);
    final theme = ref.watch(themeProvider).theme;
    final primaryColor = ref.watch(themeProvider).primaryColor;
    final brightness = theme == 'dark' ? Brightness.dark : Brightness.light;
    _setupSystemBottomNavigationBar(theme);
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: primaryColor,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.bold,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
          ),
        ),
      ),
      locale: const Locale('ru'),
      supportedLocales: const [
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Builder(
        builder: (context) {
          final groupSelected = groupId != null;
          if (groupSelected) {
            return const SchedulePage();
          }
          return const SelectGroupPage();
        },
      ),
    );
  }

  _setupSystemBottomNavigationBar(String theme) {
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    final isDark = theme == 'dark';
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: isDark ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    ));
  }
}
