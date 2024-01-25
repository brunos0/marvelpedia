import 'package:equatable/equatable.dart';

abstract class PokemonsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends PokemonsState {}

class Loading extends PokemonsState {}

class Loaded extends PokemonsState {}

class Refresh extends PokemonsState {}

class Error extends PokemonsState {
  Error({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
