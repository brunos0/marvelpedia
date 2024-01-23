import 'package:equatable/equatable.dart';

import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';

class Pokemons extends Equatable {
  const Pokemons({required this.pokemons});
  final List<Pokemon> pokemons;

  @override
  List<Object?> get props => [pokemons];
}
