import 'dart:developer';

import 'package:dev_games/model/details_game.dart';
import 'package:dev_games/model/status_details_game.dart';
import 'package:dev_games/services/remote_services.dart';
import 'package:get/get.dart';

class DetailsGameController extends GetxController {
  late Rx<DetailsGame> detailsGame = DetailsGame().obs;

  void fetchGames(int id) async {
    String link = "https://www.freetogame.com/api/game?id=$id";
    StatusDetailsGame statusDetailsGame =
        await RemoteServices.fetchDetailsGame(link);
    if (statusDetailsGame.detailsGame != null) {
      detailsGame.value = statusDetailsGame.detailsGame!;
    }
  }
}
