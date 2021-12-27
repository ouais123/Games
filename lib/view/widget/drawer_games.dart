import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:dev_games/controller/main_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerGames extends StatelessWidget {
  DrawerGames({Key? key}) : super(key: key);
  final MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            ListTileTheme(
              textColor: Get.isDarkMode ? Colors.white : Colors.red,
              iconColor: Get.isDarkMode ? Colors.white : Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    color: Get.isDarkMode ? Colors.black26 : Colors.red,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(FluentIcons.music_note_2_play_20_regular,
                            size: 50, color: Colors.white),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'G',
                                  style: TextStyle(
                                      fontFamily: "Raleway", fontSize: 30)),
                              TextSpan(
                                  text: 'ames',
                                  style: TextStyle(
                                      fontFamily: "RobotoCondensed",
                                      fontSize: 20)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      mainController.changePage(index: 0);
                    },
                    leading: const Icon(Icons.home),
                    title: Text(AppLocalizations.of(context)!.home),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      mainController.changePage(index: 1);
                    },
                    leading: const Icon(Icons.filter_list),
                    title: Text(AppLocalizations.of(context)!.filters),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      mainController.changePage(index: 2);
                    },
                    leading: const Icon(Icons.favorite),
                    title: Text(AppLocalizations.of(context)!.favourites),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Get.back();
                      mainController.changePage(index: 3);
                    },
                    leading: const Icon(Icons.language_outlined),
                    title: Text(AppLocalizations.of(context)!.language),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      mainController.changePage(index: 4);
                    },
                    leading: const Icon(Icons.wb_sunny_outlined),
                    title: Text(
                      AppLocalizations.of(context)!.theme,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
