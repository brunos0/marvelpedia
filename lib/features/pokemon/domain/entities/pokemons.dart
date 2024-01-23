import 'package:equatable/equatable.dart';

import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';

class Pokemons extends Equatable {
  const Pokemons({required this.movies});
  final List<Pokemon> movies;

  @override
  List<Object?> get props => [movies];
}
