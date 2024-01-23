import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

abstract class PokemonsRepository {
  PokemonsRepository();

  Future<(Pokemons?, Failure?)> getPokemons();
}
