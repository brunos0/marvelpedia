import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

class PokemonsModel extends Pokemons {
  const PokemonsModel({required List<Pokemon> pokemons})
      : super(pokemons: pokemons);

  factory PokemonsModel.fromJson(Map<String, dynamic> json) {
    List<Pokemon> pokemons = [];

    // TODO(bruno): implements
    /*
    final List<dynamic> jsonList = json['results'];
    int listSize = jsonList.length;

    for (int i = 0; i < listSize; i++) {
      movies.add(MovieItem(
          originalTitle:
              '${jsonList[i]['original_title'].replaceAll('\'', '')}',
          overview: '${jsonList[i]['overview'].replaceAll('\'', '')}',
          urlCover: '${jsonList[i]['poster_path']}'));
    }
    */
    return PokemonsModel(pokemons: pokemons);
  }

  // TODO(bruno): implements
  Map<String, List<Map<String, String>>> toJson() {
    List<Map<String, String>> moveItem = [];

    int listSize = pokemons.length;
    /*
    for (int i = 0; i < listSize; i++) {
      moveItem.add(
        {
          "originalTitle": movies[i].originalTitle,
          "overview": movies[i].overview,
          "urlCover": movies[i].urlCover
        },
      );
    }
    return {"result": moveItem};
    */
    return {"pokemons": []};
  }
}
