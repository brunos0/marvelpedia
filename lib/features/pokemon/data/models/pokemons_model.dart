import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

class PokemonsModel extends Pokemons {
  const PokemonsModel({required List<Pokemon> movies}) : super(movies: movies);

  factory PokemonsModel.fromJson(Map<String, dynamic> json) {
    List<Pokemon> movies = [];

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

    return MoviesModel(movies: movies);
    
  }
  */

    // TODO(bruno): implements
    Map<String, List<Map<String, String>>> toJson() {
      List<Map<String, String>> moveItem = [];

      int listSize = movies.length;
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
    }
  }
}
