import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/core/usecases/usecase.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/repositories/pokemons_repository.dart';

class GetPokemons implements UseCase<Pokemons, NoParams> {
  const GetPokemons(this.repository);
  final PokemonsRepository repository;

  @override
  Future<(Pokemons?, Failure?)> call(NoParams params) async {
    return await repository.getPokemons();
  }
}
