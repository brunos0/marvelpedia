import 'package:bloc/bloc.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_details.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_event.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({
    required this.getDetails,
  }) : super(DetailsEmpty()) {
    on<DetailsEvent>(
      (DetailsEvent event, Emitter<DetailsState> emit) async {
        if (event is DetailsLoadingEvent) {
          final (details, failure) = await getDetails(event.pokemonNumber);
          emit(DetailsLoaded(result: details!));
        }
        if (event is DetailsRefreshEvent) {
          emit(DetailsRefresh());
        }
      },
    );
  }
  final GetDetails getDetails;
}
