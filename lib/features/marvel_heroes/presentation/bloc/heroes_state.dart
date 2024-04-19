import 'package:equatable/equatable.dart';

abstract class HeroesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends HeroesState {}

class Loading extends HeroesState {}

class Loaded extends HeroesState {}

class Refresh extends HeroesState {}

class Profile extends HeroesState {}

class Error extends HeroesState {
  Error({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
