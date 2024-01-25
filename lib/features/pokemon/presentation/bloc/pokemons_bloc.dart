import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/core/usecases/usecase.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_state.dart';
import 'package:pocketpedia/injection_container.dart' as di;

const String serverFailureMessage = 'Server Failure';
const String noInternetFailureMessage = 'No Internet Failure';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonsBloc({
    required this.getPokemons,
  }) : super(Empty()) {
    on<PokemonsEvent>((PokemonsEvent event, Emitter<PokemonsState> emit) async {
      final box = di.sl<Box<Pokemons>>();
      if (box.isEmpty) {
        if (event is GetPokemonsEvent) {
          emit(Loading());
          final (pokemons, failure) = await getPokemons(NoParams());

          _eitherLoadedOrErrorState(pokemons, failure, emit);
        }
      } else {
        if (event is RefreshEvent) {
          emit(Refresh());
        }
        emit(Loaded());
      }
    });
  }

  void _eitherLoadedOrErrorState(
    Pokemons? pokemons,
    Failure? failure,
    Emitter<PokemonsState> emit,
  ) {
    if (failure != null) {
      emit(Error(message: _mapFailureToMessage(failure)));
    } else {
      emit(Loaded());
    }
  }

  final GetPokemons getPokemons;

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case NoInternetException:
        return noInternetFailureMessage;
      default:
        return 'unexpected error';
    }
  }
}
