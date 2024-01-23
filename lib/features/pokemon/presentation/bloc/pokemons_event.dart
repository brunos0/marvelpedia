import 'package:equatable/equatable.dart';

abstract class PokemonsEvent extends Equatable {
  const PokemonsEvent(List<Object?> props);
}

class GetPokemonsEvent extends PokemonsEvent {
  GetPokemonsEvent() : super([]);

  @override
  List<Object?> get props => [];
}
