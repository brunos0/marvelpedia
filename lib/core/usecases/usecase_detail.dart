import 'package:equatable/equatable.dart';
import 'package:marvelpedia/core/error/failures.dart';

abstract class UseCaseDetail<Type, Params> {
  Future<(Record?, Failure?)> call(int pokemonNumber);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
