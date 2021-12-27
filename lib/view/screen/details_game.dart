import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:dev_games/controller/favourite_controller.dart';
import 'package:dev_games/controller/details_game_controller.dart';
import 'package:dev_games/model/details_game.dart';
import 'package:dev_games/model/game.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsGames extends StatelessWidget {
  FavouriteController favouriteController = Get.put(FavouriteController());
  DetailsGameController detailsGameController =
      Get.put(DetailsGameController());

  late int id;
  late String title;
  late String thumbnail;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id = routeArg["id"]!;
    title = routeArg["title"]!;
    thumbnail = routeArg["thumbnail"]!;

    detailsGameController.fetchGames(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: "Raleway",
          ),
        ),
      ),
      body: Obx(() {
        if (detailsGameController.detailsGame.value.id == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            buildCarouselSlider(
                detailsGameController.detailsGame.value.screenshots!),
            buildGlimpse(
              shortDescription:
                  detailsGameController.detailsGame.value.short_description!,
              status: detailsGameController.detailsGame.value.status!,
              platform: detailsGameController.detailsGame.value.platform!,
              releaseDate:
                  detailsGameController.detailsGame.value.release_date!,
              genre: detailsGameController.detailsGame.value.genre!,
              publisher: detailsGameController.detailsGame.value.publisher!,
              developer: detailsGameController.detailsGame.value.developer!,
            ),
            buildMinimumSystemRequirements(
              os: detailsGameController
                  .detailsGame.value.minimum_system_requirements!.os,
              processor: detailsGameController
                  .detailsGame.value.minimum_system_requirements!.processor,
              memory: detailsGameController
                  .detailsGame.value.minimum_system_requirements!.memory,
              graphics: detailsGameController
                  .detailsGame.value.minimum_system_requirements!.graphics,
              storage: detailsGameController
                  .detailsGame.value.minimum_system_requirements!.storage,
            ),
            buildDescription(
                detailsGameController.detailsGame.value.description!),
            buildDownloadGame(
              freetogame_profile_url: detailsGameController
                  .detailsGame.value.freetogame_profile_url!,
              game_url: detailsGameController.detailsGame.value.game_url!,
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () {
            favouriteController.isFavourite(id)
                ? favouriteController.deleteGame(id)
                : favouriteController.insertGame(
                    Game(id: id, title: title, thumbnail: thumbnail));
          },
          child: Icon(
            favouriteController.isFavourite(id)
                ? FluentIcons.star_20_filled
                : FluentIcons.star_20_regular,
          ),
        ),
      ),
    );
  }

  Widget buildCarouselSlider(List<Screenshots> listUrlImage) {
    return CarouselSlider(
      items: (listUrlImage as List)
          .map((e) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  e.urlImage,
                  fit: BoxFit.fill,
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: 220,
        initialPage: 0,
        enlargeCenterPage: true,
        // autoPlay: true,
        // autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }

  Widget buildGlimpse({
    required String shortDescription,
    required String status,
    required String platform,
    required String releaseDate,
    required String genre,
    required String publisher,
    required String developer,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Glimpse",
              style: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(shortDescription),
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(Icons.cases_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Status: $status")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.integration_instructions_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Platform: $platform")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.developer_board_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Release Date: $releaseDate")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.merge_type_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Genre: $genre")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.publish_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Publisher: $publisher")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.developer_board_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(child: Text("Developer: $developer")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMinimumSystemRequirements({
    required String os,
    required String processor,
    required String memory,
    required String graphics,
    required String storage,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Minimum system requirements",
              style: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(Icons.code),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "OS: $os",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.speed_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "Processor: $processor",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.memory_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "Memory: $memory",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.graphic_eq_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "Graphics: $graphics",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(Icons.storage_outlined),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    "Storage: $storage",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDescription(String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Description",
              style: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(description),
          ],
        ),
      ),
    );
  }

  Widget buildDownloadGame({
    required String freetogame_profile_url,
    required String game_url,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Downolad",
              style: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 17,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 4,
            ),
            const Text("Profile Game"),
            InkWell(
              onTap: () {
                launch(freetogame_profile_url);
              },
              child: Text(
                freetogame_profile_url,
                style: TextStyle(
                  color: Colors.blue[800],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text("Game"),
            InkWell(
              onTap: () {
                launch(game_url);
              },
              child: Text(
                game_url,
                style: TextStyle(
                  color: Colors.blue[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
