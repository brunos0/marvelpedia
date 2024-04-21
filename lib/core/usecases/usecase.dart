import 'package:equatable/equatable.dart';
import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';

abstract class UseCase<Type, Params> {
  Future<(Heroes?, Failure?)> call(bool increment);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
