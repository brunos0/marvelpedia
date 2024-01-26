import 'package:bloc/bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc(
      //{required this.getPokemons,}
      )
      : super(DetailsEmpty()) {
    on<DetailsEvent>(
      (DetailsEvent event, Emitter<DetailsState> emit) async {
        if (event is DetailsRefreshEvent) {
          emit(DetailsRefresh());
          //  emit(DetailsLoaded());
        }
        emit(DetailsLoaded());
      },
    );
  }
}
