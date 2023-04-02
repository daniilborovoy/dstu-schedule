import 'package:dstu_schedule/features/settings/view/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';

class GoToSettingsButton extends StatelessWidget {
  const GoToSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.of(context).push(SettingsPage.create());
      },
      child: const Icon(
        CupertinoIcons.settings,
        size: 22.0,
      ),
    );
  }
}
