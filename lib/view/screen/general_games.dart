import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:dev_games/controller/games_controller.dart';
import 'package:dev_games/view/widget/item_game.dart';
import 'package:get/get.dart';

class GeneralGames extends StatelessWidget {
  GamesController gamesController = Get.put(GamesController());

  void checkConnectivity() async {
    ConnectivityResult result = await (Connectivity().checkConnectivity());
    gamesController.connectivityResult.value = result.toString();
  }

  @override
  Widget build(BuildContext context) {

    checkConnectivity();
    return Obx(
      () {
        if (gamesController.connectivityResult.value == "Unknown") {
          return Container();
        } else if (gamesController.connectivityResult.value ==
            "ConnectivityResult.none") {
          return buildNoInternet(
            text: "No internet Turn on wifi Or phone data and try again",
            icon: Icons.wifi_lock_outlined,
            onTap: () {
              checkConnectivity();
            },
          );
        } else if (gamesController.hasError.value) {
          return buildNoInternet(
              text: "There are no results or a certain failure has occurred",
              icon: Icons.error_outline_outlined,
              onTap: () {});
        } else {
          if (gamesController.generalGamesList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate:const  SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 5,
                maxCrossAxisExtent: 200,
                childAspectRatio: 200 / 165,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: gamesController.gamesShow.value,
              itemBuilder: (context, i) {
             
                if (i == (gamesController.gamesShow.value - 1) &&
                    (gamesController.gamesShow.value + 16) <
                        gamesController.generalGamesList.length) {
                  Future.delayed(const Duration(milliseconds: 3000))
                      .then((value) {
                    gamesController.gamesShow.value += 16;
                  });
                }

                return ItemGame(game: gamesController.generalGamesList[i]);
              },
            );
          }
        }
      },
    );
  }

  Widget buildNoInternet({
    required String text,
    required IconData icon,
    required Function onTap,
  }) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.red,
              size: 150,
            ),
            Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Text(text)),
            ElevatedButton(
              onPressed: () => onTap(),
              child: const Text("Try again"),
            ),
          ],
        ),
      );
}
/*
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
StaggeredGridView.builder(
              gridDelegate: SliverStaggeredGridDelegateWithMaxCrossAxisExtent(
                staggeredTileBuilder: (int index) => StaggeredTile.fit(
                    index == (generalGamesController.gamesShow.value - 1)
                        ? 16
                        : 1),
                staggeredTileCount: generalGamesController.gamesShow.value,
                mainAxisSpacing: 5,
                maxCrossAxisExtent: 200,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: generalGamesController.gamesShow.value,
              itemBuilder: (context, i) {
                log("$i");
                if (i == (generalGamesController.gamesShow.value - 1) &&
                    (generalGamesController.gamesShow.value + 16) <
                        generalGamesController.generalGamesList.length) {
                  Future.delayed(const Duration(milliseconds: 3000))
                      .then((value) {
                    generalGamesController.gamesShow.value += 16;
                  });
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return ItemGame(
                    game: generalGamesController.generalGamesList[i]);
              },
            );












 */