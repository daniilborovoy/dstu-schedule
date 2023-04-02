import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class PreferencesService {
  factory PreferencesService() => _PreferencesService();

  Color getPrimaryColor();
  Future<void> setPrimaryColor(Color color);
}

class _PreferencesService implements PreferencesService {
  @override
  Color getPrimaryColor() {
    var settingsBox = Hive.box('settings');
    var hexString = settingsBox.get('primary_color');
    if (hexString == null) {
      return Colors.blueGrey;
    }
    return HexColor.fromHex(hexString);
  }

  @override
  Future<void> setPrimaryColor(Color color) {
    var settingsBox = Hive.box('settings');
    return settingsBox.put('primary_color', color.toHex());
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
