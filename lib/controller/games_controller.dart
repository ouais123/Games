import 'package:dev_games/model/status_games.dart';
import 'package:dev_games/services/remote_services.dart';
import 'package:get/get.dart';

class GamesController extends GetxController {
  final RxBool hasError = false.obs;
  final RxString connectivityResult = "Unknown".obs;
  final RxList generalGamesList = [].obs;
  final RxInt gamesShow = 16.obs;

  @override
  void onInit() {
    fetchGames();
    super.onInit();
  }
  
  void fetchGames() async {
    try {
      StatusGames status = await RemoteServices.fetchGames(
          "https://www.freetogame.com/api/games");

      generalGamesList.value = status.listGames;
      hasError.value = status.isFail;
      defaultLengthGames();
    } finally {}
  }

  void fetchFiltersGames() async {
    try {
      StatusGames status = await RemoteServices.fetchGames(putParmetersFilters());
      generalGamesList.value = status.listGames;
      hasError.value = status.isFail;
      defaultLengthGames();
    } catch (e) {}
  }

  String putParmetersFilters() {
    String getLink = "https://www.freetogame.com/api/games?";
    String platform = "";
    String sortBy = "";
    String tags = "";

    if (listSelectedPlatform.isNotEmpty &&
        listSelectedSting.isEmpty &&
        listSelectedGenre.isEmpty &&
        listSelectedGraphics.isEmpty &&
        listSelectedCombat.isEmpty &&
        listSelectedGamePlay.isEmpty) {
      platform += "platform=";
      if (listSelectedPlatform.length >= 2) {
        platform += "all";
      } else {
        platform += listSelectedPlatform[0];
      }
    }
    if (selectedSortBy.value != "" &&
        listSelectedGenre.isEmpty &&
        listSelectedGraphics.isEmpty &&
        listSelectedCombat.isEmpty &&
        listSelectedGamePlay.isEmpty &&
        listSelectedSting.isEmpty) {
      if (platform != "") {
        sortBy += "&";
      }
      sortBy += "sort-by=" + selectedSortBy.value;
    }

    getLink += platform + sortBy;

    if (listSelectedGenre.isNotEmpty ||
        listSelectedGraphics.isNotEmpty ||
        listSelectedCombat.isNotEmpty ||
        listSelectedGamePlay.isNotEmpty ||
        listSelectedSting.isNotEmpty) {
      tags = "tag=";
      getLink = "https://www.freetogame.com/api/filter?";
      for (int i = 0; i < listSelectedGenre.length; i++) {
        tags += listSelectedGenre[i] + ".";
      }
      for (int i = 0; i < listSelectedGraphics.length; i++) {
        tags += listSelectedGraphics[i] + ".";
      }
      for (int i = 0; i < listSelectedCombat.length; i++) {
        tags += listSelectedCombat[i] + ".";
      }
      for (int i = 0; i < listSelectedGamePlay.length; i++) {
        tags += listSelectedGamePlay[i] + ".";
      }
      for (int i = 0; i < listSelectedSting.length; i++) {
        tags += listSelectedSting[i] + ".";
      }

      tags = tags.substring(0, tags.length - 1);

      if (listSelectedPlatform.isNotEmpty) {
        platform += "&platform=";
        if (listSelectedPlatform.length >= 2) {
          platform += "all";
        } else {
          platform += listSelectedPlatform[0];
        }
      }

      if (selectedSortBy.value != "") {
        sortBy += "&sort-by=" + selectedSortBy.value;
      }

      getLink += tags + platform + sortBy;
    }

    return getLink;
  }

  void defaultLengthGames() {
    if (generalGamesList.length < 16) {
      gamesShow.value = generalGamesList.length;
    }
  }

  final RxList listSelectedPlatform = [].obs;
  final RxList listSelectedGenre = [].obs;
  final RxList listSelectedGraphics = [].obs;
  final RxList listSelectedCombat = [].obs;
  final RxList listSelectedGamePlay = [].obs;
  final RxList listSelectedSting = [].obs;
  final RxString selectedSortBy = "".obs;
}
