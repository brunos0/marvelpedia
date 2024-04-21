import 'package:equatable/equatable.dart';

abstract class HeroesEvent extends Equatable {
  const HeroesEvent(List<Object?> props);
}

class GetHeroesEvent extends HeroesEvent {
  GetHeroesEvent({required this.increment}) : super([]);

  bool increment;

  @override
  List<Object?> get props => [increment];
}

class RefreshEvent extends HeroesEvent {
  RefreshEvent() : super([]);

  @override
  List<Object?> get props => [];
}

class ProfileEvent extends HeroesEvent {
  ProfileEvent() : super([]);

  @override
  List<Object?> get props => [];
}
