import 'package:equatable/equatable.dart';

abstract class DetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailsEmpty extends DetailsState {}

class DetailsLoaded extends DetailsState {
  DetailsLoaded({required this.result});

  final Record result;

  @override
  List<Object?> get props => [result];
}

class DetailsRefresh extends DetailsState {}

class DetailsError extends DetailsState {
  DetailsError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
