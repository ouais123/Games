import 'package:flutter/material.dart';
import 'package:dev_games/controller/favourite_controller.dart';
import 'package:dev_games/view/widget/item_game.dart';
import 'package:get/get.dart';

class FavouriteGames extends StatelessWidget {
  FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 5,
          maxCrossAxisExtent: 200,
          childAspectRatio: 200 / 160,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: favouriteController.favouriteList.length,
        itemBuilder: (context, i) {
          return ItemGame(game: favouriteController.favouriteList[i]);
        },
      );
    });
  }
}
