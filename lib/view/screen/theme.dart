import 'package:dev_games/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyTheme extends StatelessWidget {
  MyTheme({Key? key}) : super(key: key);

  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.systemTheme),
                  value: "system",
                  groupValue: mainController.gropId.value,
                  onChanged: (newMode) {
                    mainController.changeModeTheme(newMode!);
                  }),
              RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.darkTheme),
                  value: "dark",
                  groupValue: mainController.gropId.value,
                  onChanged: (newMode) {
                    mainController.changeModeTheme(newMode!);
                  }),
              RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.lightTheme),
                  value: "light",
                  groupValue: mainController.gropId.value,
                  onChanged: (newMode) {
                    mainController.changeModeTheme(newMode!);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
