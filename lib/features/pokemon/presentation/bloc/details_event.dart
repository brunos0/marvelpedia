import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent(List<Object?> props);
}

class DetailsRefreshEvent extends DetailsEvent {
  DetailsRefreshEvent() : super([]);

  @override
  List<Object?> get props => [];
}

class DetailsLoadingEvent extends DetailsEvent {
  DetailsLoadingEvent(this.pokemonNumber) : super([pokemonNumber]);

  final int pokemonNumber;

  @override
  List<Object?> get props => [pokemonNumber];
}
