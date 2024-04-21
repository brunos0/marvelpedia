import 'package:marvelpedia/features/marvel_heroes/domain/entities/hero.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';

class HeroesModel extends Heroes {
  HeroesModel({required List<Hero> heroes, required step})
      : super(heroes: heroes, step: step);

  increaseStep() {
    step = step++;
  }

  factory HeroesModel.fromJson(Map<String, dynamic> json) {
    List<Hero> heroes = [];

    // TODO(bruno): implements

    final List<dynamic> jsonList = json['data']['results'];
    int listSize = jsonList.length;

    for (int i = 0; i < listSize; i++) {
      var listComicsJson = jsonList[i]['comics']['items'] as List;
      final listComics = [];
      if (listComicsJson.isNotEmpty) {
        listComicsJson.forEach((element) {
          listComics.add(element['name']);
        });
      }
      //.forEach
      heroes.add(Hero(
          id: jsonList[i]['id'],
          name: '${jsonList[i]['name']}',
          profilePicture:
              '${jsonList[i]['thumbnail']['path']}.${jsonList[i]['thumbnail']['extension']}',
          comics: listComics

          //'${jsonList[i]['comics']['items'][name]}}'},
          ));
    }

    return HeroesModel(heroes: heroes, step: 1);
  }

  String detailsFromJson(Map<String, dynamic> json) {
    final description = json['description'];

    return description;
  }
}
