import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';

part 'pokemons.g.dart';

@HiveType(typeId: 1)
class Pokemons extends HiveObject with EquatableMixin {
  Pokemons({
    required this.pokemons,
    this.step = 0,
  });

  @HiveField(0)
  final List<Pokemon> pokemons;

  @HiveField(1)
  int step;

  @override
  List<Object?> get props => [pokemons];
}
