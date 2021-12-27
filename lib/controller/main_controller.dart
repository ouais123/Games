import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {

  late RxString gropId = "system".obs;

  @override
  void onInit() {
    getSystemMode();
    super.onInit();
  }

  Future<void> getSystemMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? systemMode = prefs.getString("systemMode");
    if (systemMode != null) {
      gropId.value = systemMode;
    } else {
      gropId.value = "system";
    }

    switch (gropId.value) {
      case "light":
        {
          Get.changeThemeMode(ThemeMode.light);
          break;
        }
      case "dark":
        {
          Get.changeThemeMode(ThemeMode.dark);
          break;
        }
      default:
        {
          Get.changeThemeMode(ThemeMode.system);
        }
    }
  }

  RxInt page = 0.obs;

  void changeModeTheme(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("systemMode", mode);
    gropId.value = mode;

    switch (gropId.value) {
      case "light":
        {
          Get.changeThemeMode(ThemeMode.light);
          break;
        }
      case "dark":
        {
          Get.changeThemeMode(ThemeMode.dark);
          break;
        }
      default:
        {
          Get.changeThemeMode(ThemeMode.system);
        }
    }
  }

  void changePage({required int index}) {
    page.value = index;
  }
}
