import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

abstract class DetailsRepository {
  DetailsRepository();

  Future<(Record?, Failure?)> getDetails(int pokemonNumber);
}
