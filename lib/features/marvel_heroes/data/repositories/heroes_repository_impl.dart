import 'package:marvelpedia/core/error/exceptions.dart';
import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/core/platfom/network_info.dart';
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source.dart';
import 'package:marvelpedia/features/marvel_heroes/data/models/heroes_model.dart';
import 'package:marvelpedia/features/marvel_heroes/repositories/heroes_repository.dart';

class HeroesRepositoryImpl implements HeroesRepository {
  const HeroesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  final HeroesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<(HeroesModel?, Failure?)> getHeroes(increment) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final heroesModel = await remoteDataSource.getHeroes(increment);

        return (heroesModel, null);
      } on ServerException {
        return (null, ServerFailure());
      }
    } else {
      return (null, NoInternetException());
    }
  }
}
