import 'package:bloc/bloc.dart';
//import 'package:pocketpedia/core/error/failures.dart';
//import 'package:pocketpedia/core/usecases/usecase_detail.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_details.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({
    required this.getDetails,
    required this.pokemonNumber,
  }) : super(DetailsEmpty()) {
    on<DetailsEvent>(
      (DetailsEvent event, Emitter<DetailsState> emit) async {
        if (event is DetailsLoadingEvent) {
          final (details, failure) = await getDetails(pokemonNumber);
          emit(DetailsLoaded(result: details!));
        }
        if (event is DetailsRefreshEvent) {
          emit(DetailsRefresh());
          //  emit(DetailsLoaded());
        }
      },
    );
  }
  final GetDetails getDetails;
  final int pokemonNumber;
/*
  void _eitherLoadedOrErrorState(
    Record? details,
    Failure? failure,
    Emitter<DetailsState> emit,
  ) {
    if (failure != null) {
      emit(DetailsError(message: _mapFailureToMessage(failure)));
    } else {
      emit(DetailsLoaded());
    }
  }

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
  */
}
