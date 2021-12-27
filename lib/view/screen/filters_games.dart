import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dev_games/controller/games_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FiltersGames extends StatelessWidget {
  final GamesController gamesController = Get.put(GamesController());
  final List<String> listPlatform = ["pc", "browser"];
  final List<String> listGenre = [
    "mmo",
    "mmorpg",
    "shooter",
    "strategy",
    "moba",
    "card",
    "racing",
    "sports",
    "social",
    "fighting"
  ];

  final List<String> listGraphics = ["3d", "2d"]; //Graphics
  final List<String> listCombat = ["PVE", "PVP"];
  final List<String> listGameplay = [
    "turn-based",
    "first-person",
    "third-Person"
  ];

  final List<String> listSetting = [
    "anime",
    "fantasy",
    "sci-fi",
    "military",
    "horror"
  ];

  final List<String> listSortBy = [
    "alphabetical",
    "release-date",
    "popularity",
    "relevance"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.selectGame,
              style: TextStyle(
                fontFamily: "Raleway",
                fontWeight: FontWeight.w500,
                fontSize: 25.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            buildTitle(title: AppLocalizations.of(context)!.category),
            const SizedBox(height: 10),
            const Divider(height: 3),
            const SizedBox(height: 12),
            buildCustomDropDownMultiSelection(
              id: 0,
              labelText: "Genre",
              hintText: "selecte the Genres",
              maxHeight: 350,
              icon: FluentIcons.scan_type_24_regular,
              items: listGenre,
              popupTitle: "Genre",
            ),
            const SizedBox(height: 12),
            buildCustomDropDownMultiSelection(
              id: 1,
              labelText: "Graphics",
              hintText: "selecte the Graphics",
              maxHeight: 225,
              icon: FluentIcons.draw_shape_24_regular,
              items: listGraphics,
              popupTitle: "Graphics",
            ),
            const SizedBox(height: 12),
            buildCustomDropDownMultiSelection(
              id: 2,
              labelText: "Combat",
              hintText: "selecte the Combat",
              maxHeight: 225,
              icon: FluentIcons.tab_16_filled,
              items: listCombat,
              popupTitle: "Combat",
            ),
            const SizedBox(height: 12),
            buildCustomDropDownMultiSelection(
              id: 3,
              labelText: "Gameplay",
              hintText: "selecte the Gameplay",
              maxHeight: 225,
              icon: FluentIcons.play_12_regular,
              items: listGameplay,
              popupTitle: "Gameplay",
            ),
            const SizedBox(height: 12),
            buildCustomDropDownMultiSelection(
              id: 4,
              labelText: "Setting",
              hintText: "selecte the Setting",
              maxHeight: 350,
              icon: FluentIcons.settings_16_regular,
              items: listSetting,
              popupTitle: "Setting",
            ),
            const SizedBox(height: 12),
            buildTitle(title: AppLocalizations.of(context)!.platform),
            const SizedBox(height: 10),
            const Divider(height: 3),
            const SizedBox(height: 12),
            buildCustomDropDownMultiSelection(
              id: 5,
              labelText: "platform",
              hintText: "selecte the platforms",
              maxHeight: 225,
              icon: FluentIcons.screen_person_20_regular,
              items: listPlatform,
              popupTitle: "Platform",
            ),
            const SizedBox(height: 12),
            buildTitle(title: AppLocalizations.of(context)!.sortBy),
            const SizedBox(height: 10),
            const Divider(height: 3),
            const SizedBox(height: 12),
            buildCustomDropDown(
              labelText: "Sort By",
              hintText: "chosse the way sort",
              maxHeight: 300,
              icon: Icons.sort_outlined,
              items: listSortBy,
              popupTitle: "Sort By",
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                onPressed: () {
                  gamesController.fetchFiltersGames();
                },
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildTitle({required String title}) => SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: "RobotoCondensed",
          ),
          textAlign: TextAlign.start,
        ),
      );

  RxList specifyLsit(int id) {
    switch (id) {
      case 0:
        return gamesController.listSelectedGenre;

      case 1:
        return gamesController.listSelectedGraphics;

      case 2:
        return gamesController.listSelectedCombat;

      case 3:
        return gamesController.listSelectedGamePlay;

      case 4:
        return gamesController.listSelectedSting;

      default:
        return gamesController.listSelectedPlatform;
    }
  }

  Widget buildCustomDropDownMultiSelection({
    required int id,
    required String labelText,
    required String hintText,
    required double maxHeight,
    required IconData icon,
    required List<String> items,
    required String popupTitle,
  }) {
    RxList selectedItems = specifyLsit(id);

    return Obx(() {
      // log(selectedItems.toString());
      return DropdownSearch<String>.multiSelection(
        mode: Mode.BOTTOM_SHEET,
        isFilteredOnline: true,
        showClearButton: true,
        showSelectedItems: true,
        maxHeight: maxHeight,
        items: items,
        selectedItems:
            selectedItems.map((element) => element as String).toList(),
        dropdownBuilder:
            selectedItems.isEmpty ? null : _customDropDownMultiSelection,
        dropdownSearchDecoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        popupItemDisabled: (String s) => s.startsWith('I'),
        clearButtonSplashRadius: 20,
        onChanged: (val) {
          selectedItems.clear();
          selectedItems.addAll(val);
        },
        popupTitle: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.blue[700] : Colors.red,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              popupTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        showAsSuffixIcons: true,
        popupShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );
    });
  }

  Widget _customDropDownMultiSelection(
      BuildContext context, List<String> selectedItems) {
    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Icon(
              Icons.adjust_outlined,
              color: Get.isDarkMode ? Colors.blue[700] : Colors.red,
            ),
            title: Text(
              e,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.blue[700] : Colors.red,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildCustomDropDown({
    required String labelText,
    required String hintText,
    required double maxHeight,
    required IconData icon,
    required List<String> items,
    required String popupTitle,
  }) {
    return Obx(() {
      return DropdownSearch<String>(
        mode: Mode.BOTTOM_SHEET,
        isFilteredOnline: true,
        showClearButton: true,
        showSelectedItems: true,
        maxHeight: maxHeight,
        items: items,
        selectedItem: gamesController.selectedSortBy.value == ""
            ? null
            : gamesController.selectedSortBy.value,
        dropdownBuilder:
            gamesController.selectedSortBy.value == "" ? null : _customDropDown,
        dropdownSearchDecoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        popupItemDisabled: (String s) => s.startsWith('I'),
        clearButtonSplashRadius: 20,
        onChanged: (val) {
          if (val != null) {
            gamesController.selectedSortBy.value = val;
          } else {
            gamesController.selectedSortBy.value = "";
          }
        },
        popupTitle: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.blue[700] : Colors.red,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              popupTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        showAsSuffixIcons: true,
        popupShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      );
    });
  }

  Widget _customDropDown(BuildContext context, String? selectedItem) {
    if (selectedItem == null) {
      return Wrap();
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Icon(
          Icons.adjust_outlined,
          color: Get.isDarkMode ? Colors.blue[700] : Colors.red,
        ),
        title: Text(
          selectedItem,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.blue[700] : Colors.red,
          ),
        ),
      ),
    );
  }
}
