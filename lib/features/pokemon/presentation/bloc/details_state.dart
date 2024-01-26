import 'package:equatable/equatable.dart';

abstract class DetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailsEmpty extends DetailsState {}

class DetailsLoaded extends DetailsState {}

class DetailsRefresh extends DetailsState {}
