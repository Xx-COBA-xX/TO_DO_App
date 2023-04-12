// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();

  final String _key = "isDarkTheme";

  _saveThemeToBox(bool isDarkTheme) {
    _box.write(_key, isDarkTheme);
  }

  bool _loadThemeFromBox() {
    return _box.read<bool>(_key) ?? false;
  }

  ThemeMode get theme => _loadThemeFromBox()? ThemeMode.dark: ThemeMode.light;

  switchThemeMode(){
    Get.changeThemeMode(_loadThemeFromBox()? ThemeMode.light: ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
