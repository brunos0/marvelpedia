import 'package:bloc/bloc.dart';
import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/usecases/get_heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_event.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_state.dart';

const String serverFailureMessage = 'Server Failure';
const String noInternetFailureMessage = 'No Internet Failure';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  HeroesBloc({
    required this.getHeroes,
  }) : super(Empty()) {
    on<HeroesEvent>((HeroesEvent event, Emitter<HeroesState> emit) async {
      if (event is GetHeroesEvent) {
        if (!event.increment) {
          emit(Loading());
          await Future.delayed(const Duration(seconds: 40));
        }

        final (heroes, failure) = await getHeroes(event.increment);

        _eitherLoadedOrErrorState(heroes, failure, emit);
      } else {
        if (event is RefreshEvent) {
          emit(Refresh());
          emit(Loaded());
          return;
        } else if (event is ProfileEvent) {
          emit(Profile());
          return;
        }
        emit(Loaded());
      }
    });
  }

  void _eitherLoadedOrErrorState(
      Heroes? heroes, Failure? failure, Emitter<HeroesState> emit) {
    if (failure != null) {
      emit(Error(message: _mapFailureToMessage(failure)));
    } else {
      emit(Loaded());
    }
  }

  final GetHeroes getHeroes;

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
