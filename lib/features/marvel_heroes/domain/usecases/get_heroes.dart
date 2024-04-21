import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/core/usecases/usecase.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/repositories/heroes_repository.dart';

class GetHeroes implements UseCase<Heroes, bool> {
  const GetHeroes(this.repository);
  final HeroesRepository repository;

  @override
  Future<(Heroes?, Failure?)> call(increment) async {
    return await repository.getHeroes(increment);
  }
}
