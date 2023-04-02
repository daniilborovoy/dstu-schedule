import 'package:dstu_schedule/app.dart';
import 'package:dstu_schedule/features/schedule/view/pages/select_group_page.dart';
import 'package:dstu_schedule/features/settings/services/preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

final developerTelegramLink = dotenv.env['DEVELOPER_TELEGRAM_LINK'] ?? '';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  static create() {
    return CupertinoPageRoute(builder: (context) {
      return const SettingsPage();
    });
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Настройки'),
        leading: CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const UserGroupInfo(),
              // Divider(
              //   color: CupertinoTheme.of(context).primaryColor,
              //   height: 0,
              //   indent: 16,
              //   endIndent: 16,
              // ),
              CupertinoButton(
                  child: const Text("Поменять группу"),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      SelectGroupPage.create(),
                      (route) => false,
                    );
                  }),
              const Divider(
                  color: CupertinoColors.systemFill,
                  height: 0,
                  indent: 16,
                  endIndent: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child:
                              ref.read(themeProvider.notifier).theme == 'dark'
                                  ? const Icon(
                                      CupertinoIcons.moon_fill,
                                      key: ValueKey<int>(0),
                                    )
                                  : const Icon(
                                      CupertinoIcons.sun_max_fill,
                                      key: ValueKey<int>(1),
                                    ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Темная тема",
                          style: TextStyle(
                            color: CupertinoTheme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CupertinoSwitch(
                      value: ref.watch(themeProvider).theme == 'dark',
                      activeColor: CupertinoTheme.of(context).primaryColor,
                      onChanged: (value) {
                        final theme = value ? 'dark' : 'light';
                        ref.read(themeProvider.notifier).theme = theme;
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                          systemNavigationBarColor:
                              value ? Colors.black : Colors.white,
                          systemNavigationBarIconBrightness:
                              value ? Brightness.light : Brightness.dark,
                        ));
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: CupertinoColors.systemFill,
                height: 0,
                indent: 16,
                endIndent: 16,
              ),
              const Divider(
                  color: CupertinoColors.systemFill,
                  height: 0,
                  indent: 16,
                  endIndent: 16),
              CupertinoButton(
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.text_bubble_fill),
                    SizedBox(
                      width: 16,
                    ),
                    Text("Написать разработчику"),
                  ],
                ),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text("Написать разработчику"),
                        content:
                            const Text("Версия текущего приложения: 0.0.1"),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("Отмена"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text("Перейти в Telegram"),
                            onPressed: () {
                              launchUrlString(developerTelegramLink);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              CupertinoButton(
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.color_filter),
                    SizedBox(
                      width: 16,
                    ),
                    Text('Поменять цвет'),
                  ],
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Color pickerColor = const Color(0xff443a49);
                      Color currentColor = const Color(0xff443a49);
                      return CupertinoAlertDialog(
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                          ),
                        ),
                        actions: <Widget>[
                          CupertinoButton(
                            child: const Text('Подтвердить'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeColor(Color color) {
    final preferencesService = PreferencesService();
    preferencesService.setPrimaryColor(color);
    ref.read(themeProvider.notifier).primaryColor = color;
  }
}
