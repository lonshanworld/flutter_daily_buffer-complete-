import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';

class ThemeService{
  final _storagebox = GetStorage();
  final _key = "isDarkMode";

  bool _loadThemeFromStoragebox() => _storagebox.read(_key) ?? false;
  _saveThemeToStorageBox(bool isDarkMode) => _storagebox.write(_key, isDarkMode);

  ThemeMode get theme => _loadThemeFromStoragebox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromStoragebox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToStorageBox(!_loadThemeFromStoragebox());
  }
}