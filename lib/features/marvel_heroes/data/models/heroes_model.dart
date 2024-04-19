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

    final List<dynamic> jsonList = json['results'];
    int listSize = jsonList.length;

    for (int i = 0; i < listSize; i++) {
      heroes.add(Hero(
          id: jsonList[i]['id'],
          /*
        '${jsonList[i]['url'].split('https://pokeapi.co/api/v2/pokemon/')[1].replaceAll('/', '')
            //.replaceAll('\'', '')
            }',
            */
          name: '${jsonList[i]['name']}',
          // fix this
          comics: [] //'${jsonList[i]['comics']}',
          ));
    }

    return HeroesModel(heroes: heroes, step: 1);
  }

  String detailsFromJson(Map<String, dynamic> json) {
    final description = json['description'];

    return description;
  }
}
