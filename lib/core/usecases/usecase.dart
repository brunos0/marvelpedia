import 'package:equatable/equatable.dart';
import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';

abstract class UseCase<Type, Params> {
  Future<(Pokemons?, Failure?)> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
