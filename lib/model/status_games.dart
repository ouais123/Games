import 'package:dev_games/model/game.dart';

class StatusGames {
  bool isFail;
  String message;
  List<Game> listGames;
  StatusGames({
    required this.isFail,
    required this.message,
    required this.listGames,
  });
}
