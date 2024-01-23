import 'package:pocketpedia/core/error/exceptions.dart';
import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/core/platfom/network_info.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remore_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/models/pokemons_model.dart';
import 'package:pocketpedia/features/pokemon/repositories/pokemons_repository.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  const PokemonsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  final PokemonsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<(PokemonsModel?, Failure?)> getPokemons() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final pokemonsModel = await remoteDataSource
            .getPokemons(); //retorna apenas um tipo de dado

        return (pokemonsModel, null); // mas repositório retorna dois
      } on ServerException {
        return (null, ServerFailure());
      }
    } else {
      return (null, NoInternetException());
    }
  }
}
