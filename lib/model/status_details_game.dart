import 'package:dev_games/model/details_game.dart';

class StatusDetailsGame {
  bool isFail;
  String message;
  DetailsGame? detailsGame;

  StatusDetailsGame({
    required this.isFail,
    required this.message,
    required this.detailsGame,
  });
}
