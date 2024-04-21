import 'package:marvelpedia/features/marvel_heroes/data/models/heroes_model.dart';

abstract class HeroesRemoteDataSource {
  Future<HeroesModel?> getHeroes(bool increment);
  Future<Record> getDetail(int index);
}
