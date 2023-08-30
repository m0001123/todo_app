import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemeService{
  final _box = GetStorage();
  final _key = 'isDarkMode';

  bool _loadThemeFromStorage() => _box.read(_key)??false;
  ThemeMode get theme=> _loadThemeFromStorage()?ThemeMode.dark:ThemeMode.light;
  void switchTheme(){
    Get.changeThemeMode( _loadThemeFromStorage()?ThemeMode.light:ThemeMode.dark);
    _box.write(_key, !_loadThemeFromStorage());
  }

}