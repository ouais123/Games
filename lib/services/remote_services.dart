import 'dart:convert';
import 'dart:developer';

import 'package:dev_games/model/details_game.dart';
import 'package:dev_games/model/game.dart';
import 'package:dev_games/model/status_details_game.dart';
import 'package:dev_games/model/status_games.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<StatusGames> fetchGames(String link) async {
    var url = Uri.parse(link);

    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        List<dynamic> responseBody = jsonDecode(response.body);

        List<Game> generalgames =
            responseBody.map((e) => Game.fromMap(e)).toList();
        log("generalgames : " + generalgames.length.toString());
        return StatusGames(
            isFail: false,
            message: "The operation was successful",
            listGames: generalgames);
      } else {
        return StatusGames(
            isFail: true, message: "Operation failed", listGames: []);
      }
    } catch (e) {
      log(e.toString(), name: "Error");
      return StatusGames(isFail: true, message: "Has Error", listGames: []);
    }
  }

  static Future<StatusDetailsGame> fetchDetailsGame(String link) async {
   
    var url = Uri.parse(link);

    try {
      var response = await client.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        DetailsGame detailsGame = DetailsGame.fromMap(responseBody);

        return StatusDetailsGame(
            isFail: false,
            message: "The operation was successful",
            detailsGame: detailsGame);
      } else {
        return StatusDetailsGame(
            isFail: false, message: "Operation failed", detailsGame: null);
      }
    } catch (e) {
      log(e.toString(), name: "Error");
      return StatusDetailsGame(
          isFail: false, message: "Has Error", detailsGame: null);
    }
  }
}
