import 'dart:convert';

import 'package:flutter/foundation.dart';

class Game {
  int id;
  String title;
  String thumbnail;
  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() {
    return {
      'idGame': id,
      'title': title,
      'urlImage': thumbnail,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
    );
  }

}













/*ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshat.data!.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          "${snapshat.data![i]['thumbnail']}",
                          height: 84,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                        Expanded(
                          child: Container(
                            height: 84,
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "${snapshat.data![i]['title']}",
                                      textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),),),
                                Expanded(
                                  child: Text(
                                    "description: ${snapshat.data![i]['short_description']}",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                    "Platform: ${snapshat.data![i]['platform']}"),
                                Text(
                                    "Release date: ${snapshat.data![i]['release_date']}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );*/