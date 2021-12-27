import 'dart:developer';

import 'package:dev_games/model/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemGame extends StatelessWidget {
  Game game;
  ItemGame({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {

      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
            onTap: () {
              Get.toNamed("/detailsGame", arguments: {
                "id": game.id,
                "title": game.title,
                "thumbnail": game.thumbnail,
              });
            },
            child: Column(
             
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    "${game.thumbnail}",
                    height: constraints.maxHeight * 0.70,
                    width: constraints.maxWidth,
                    fit: BoxFit.fill,
                    errorBuilder: (context, object, tracke) {
                      return Container();
                    },
                  ),
                ),
                Expanded(
             /*     height: constraints.maxHeight * 0.2,
                  width: constraints.maxWidth,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),*/
                  child: Container(
                    alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    child: Text(
                      game.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
