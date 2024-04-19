import 'package:marvelpedia/core/error/exceptions.dart';
import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/core/platfom/network_info.dart';
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source.dart';
import 'package:marvelpedia/features/marvel_heroes/repositories/details_repository.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  const DetailsRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  final HeroesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<(Record?, Failure?)> getDetails(int pokemonNumber) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final pokemonsDetail = await remoteDataSource.getDetail(pokemonNumber);

        return (pokemonsDetail, null); // mas repositório retorna dois
      } on ServerException {
        return (null, ServerFailure());
      }
    } else {
      return (null, NoInternetException());
    }
  }
}
