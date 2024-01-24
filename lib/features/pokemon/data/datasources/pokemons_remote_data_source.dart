import 'package:pocketpedia/features/pokemon/data/models/pokemons_model.dart';

abstract class PokemonsRemoteDataSource {
  Future<PokemonsModel?> getPokemons();
}
