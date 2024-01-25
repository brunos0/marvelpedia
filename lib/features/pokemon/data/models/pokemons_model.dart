import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

class PokemonsModel extends Pokemons {
  PokemonsModel({required List<Pokemon> pokemons, required step})
      : super(pokemons: pokemons, step: step);

  increaseStep() {
    step = step++;
  }

  factory PokemonsModel.fromJson(Map<String, dynamic> json) {
    List<Pokemon> pokemons = [];

    // TODO(bruno): implements

    final List<dynamic> jsonList = json['results'];
    int listSize = jsonList.length;

    for (int i = 0; i < listSize; i++) {
      pokemons.add(Pokemon(
        number:
            '${jsonList[i]['url'].split('https://pokeapi.co/api/v2/pokemon/')[1].replaceAll('/', '')
            //.replaceAll('\'', '')
            }',
        name: '${jsonList[i]['name']}',
      ));
    }

    return PokemonsModel(pokemons: pokemons, step: 1);
  }

  (
    List<String> listAbilities,
    List<Map<String, dynamic>> listStats,
    List<String> listMovies,
    double weight,
    double height,
    List<String> listTypes
  ) detailsFromJson(Map<String, dynamic> json) {
    final List<String> listAbilities = [];
    final List<Map<String, dynamic>> listStats = [];
    final List<String> listMoves = [];
    final List<String> listTypes = [];
    final abilities = json['abilities'];
    final stats = json['stats'];
    final moves = json['moves'];
    final double weight = json['weight'] / 10;
    final double height = json['height'] / 1;
    final types = json['types'];

    final listSize = abilities.length;
    for (int i = 0; i < listSize; ++i) {
      listAbilities.add(abilities[i]['ability']['name']);
    }

    final listStatsSize = stats.length;
    for (int i = 0; i < listStatsSize; ++i) {
      listStats.add({
        stats[i]['stat']['name']: stats[i]['base_stat'],
      });
    }

    final listMovesSize = moves.length;
    for (int i = 0; i < listMovesSize; ++i) {
      listMoves.add(moves[i]['move']['name']);
    }

    final listTypesSize = types.length;
    for (int i = 0; i < listTypesSize; ++i) {
      listTypes.add(types[i]['type']['name']);
    }

    return (listAbilities, listStats, listMoves, weight, height, listTypes);
  }
}
