import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';

abstract class HeroesRepository {
  HeroesRepository();

  Future<(Heroes?, Failure?)> getHeroes();
}
