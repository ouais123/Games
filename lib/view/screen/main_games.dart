import 'dart:developer';

import 'package:dev_games/view/screen/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dev_games/controller/main_controller.dart';
import 'package:dev_games/model/page.dart';
import 'package:dev_games/view/screen/account.dart';
import 'package:dev_games/view/screen/favourite_games.dart';
import 'package:dev_games/view/screen/filters_games.dart';
import 'package:dev_games/view/screen/general_games.dart';
import 'package:dev_games/view/screen/language.dart';
import 'package:dev_games/view/widget/drawer_games.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainGames extends StatelessWidget {
  final MainController mainController = Get.put(MainController());

  List<DrawerBody> listPages = [];

  @override
  Widget build(BuildContext context) {

    listPages = [
      DrawerBody(
          body: GeneralGames(), title: AppLocalizations.of(context)!.games),
      DrawerBody(
          body: FiltersGames(), title: AppLocalizations.of(context)!.filters),
      DrawerBody(
          body: FavouriteGames(),
          title: AppLocalizations.of(context)!.favourites),
      DrawerBody(
          body: MyLanguage(), title: AppLocalizations.of(context)!.language),
      DrawerBody(body: MyTheme(), title: AppLocalizations.of(context)!.theme)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            listPages[mainController.page.value].title,
            style: const TextStyle(
              fontFamily: "Raleway",
            ),
          );
        }),
      ),
      drawer: DrawerGames(),
      body: Obx(() {
        return listPages[mainController.page.value].body;
      }),
    );
  }
}
