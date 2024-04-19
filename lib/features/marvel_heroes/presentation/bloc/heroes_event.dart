import 'package:equatable/equatable.dart';

abstract class HeroesEvent extends Equatable {
  const HeroesEvent(List<Object?> props);
}

class GetHeroesEvent extends HeroesEvent {
  GetHeroesEvent() : super([]);

  @override
  List<Object?> get props => [];
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
