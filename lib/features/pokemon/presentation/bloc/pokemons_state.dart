import 'package:equatable/equatable.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

abstract class PokemonsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends PokemonsState {}

class Loading extends PokemonsState {}

class Loaded extends PokemonsState {
  Loaded({required this.pokemons});
  final Pokemons pokemons;

  @override
  List<Object?> get props => [pokemons];
}

class Error extends PokemonsState {
  Error({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
