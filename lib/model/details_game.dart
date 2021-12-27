import 'dart:convert';

import 'dart:developer';

class DetailsGame {
  int? id;
  String? status;
  String? short_description;
  String? description;
  String? game_url;
  String? genre;
  String? platform;
  String? publisher;
  String? developer;

  String? release_date;
  String? freetogame_profile_url;
  MinimumSystemRequirements? minimum_system_requirements;
  List<Screenshots>? screenshots;

  DetailsGame({
    this.id,
    this.status,
    this.short_description,
    this.description,
    this.game_url,
    this.genre,
    this.platform,
    this.publisher,
    this.developer,
    this.release_date,
    this.freetogame_profile_url,
    this.minimum_system_requirements,
    this.screenshots,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'short_description': short_description,
      'description': description,
      'game_url': game_url,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': release_date,
      'freetogame_profile_url': freetogame_profile_url,
      'minimum_system_requirements': minimum_system_requirements!.toMap(),
      'screenshots': screenshots,
    };
  }

  factory DetailsGame.fromMap(Map<String, dynamic> map) {
    return DetailsGame(
      id: map['id'],
      status: map['status'],
      short_description: map['short_description'],
      description: map['description'],
      game_url: map['game_url'],
      genre: map['genre'],
      platform: map['platform'],
      publisher: map['publisher'],
      developer: map['developer'],
      release_date: map['release_date'],
      freetogame_profile_url: map['freetogame_profile_url'],
      minimum_system_requirements:
          MinimumSystemRequirements.fromMap(map['minimum_system_requirements']),
      screenshots: (map['screenshots'] as List)
          .map((e) => Screenshots.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsGame.fromJson(String source) =>
      DetailsGame.fromMap(json.decode(source));
}

class MinimumSystemRequirements {
  String os;
  String processor;
  String memory;
  String graphics;
  String storage;
  MinimumSystemRequirements({
    required this.os,
    required this.processor,
    required this.memory,
    required this.graphics,
    required this.storage,
  });

  Map<String, dynamic> toMap() {
    return {
      'os': os,
      'processor': processor,
      'memory': memory,
      'graphics': graphics,
      'storage': storage,
    };
  }

  factory MinimumSystemRequirements.fromMap(Map<String, dynamic> map) {
    return MinimumSystemRequirements(
      os: map['os'],
      processor: map['processor'],
      memory: map['memory'],
      graphics: map['graphics'],
      storage: map['storage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MinimumSystemRequirements.fromJson(String source) =>
      MinimumSystemRequirements.fromMap(json.decode(source));
}

class Screenshots {
  int id;
  String urlImage;
  Screenshots({
    required this.id,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urlImage': urlImage,
    };
  }

  factory Screenshots.fromMap(Map<String, dynamic> map) {
    return Screenshots(
      id: map['id'],
      urlImage: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Screenshots.fromJson(String source) =>
      Screenshots.fromMap(json.decode(source));
}
