import 'dart:developer';

import 'package:dev_games/db/db_helper.dart';
import 'package:dev_games/model/game.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  final RxList favouriteList = [].obs;

  @override
  void onInit() {
    getDataFromDb();
    super.onInit();
  }

  void getDataFromDb() async {
    List<Map<String, dynamic>> list = await DBHelper.query();
    favouriteList.value = list.map((record) {
      return Game(
        id: record["idGame"],
        title: record["title"],
        thumbnail: record["urlImage"],
      );
    }).toList();
    log(favouriteList.toString());
  }

  void insertGame(Game game) async {
    int id = await DBHelper.insert(game);
    favouriteList.add(game);
    log("insert : " + id.toString());
  }

  void deleteGame(int idGame) async {
    int id = await DBHelper.delete(idGame);
    favouriteList.removeWhere((game) => game.id == idGame);
    log("delete : " + id.toString());
  }

  bool isFavourite(int id) {
    return favouriteList.value.any((element) => element.id == id);
  }
}
