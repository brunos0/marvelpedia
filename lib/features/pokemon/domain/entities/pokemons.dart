import 'package:equatable/equatable.dart';

import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';

class Pokemons extends Equatable {
  Pokemons({
    required this.pokemons,
    this.step = 0,
  });
  final List<Pokemon> pokemons;
  int step;

  @override
  List<Object?> get props => [pokemons];
}
