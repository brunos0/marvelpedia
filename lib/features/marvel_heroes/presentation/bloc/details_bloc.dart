import 'package:bloc/bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/usecases/get_details.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_event.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc({
    required this.getDetails,
  }) : super(DetailsEmpty()) {
    on<DetailsEvent>(
      (DetailsEvent event, Emitter<DetailsState> emit) async {
        if (event is DetailsLoadingEvent) {
          final (details, failure) = await getDetails(event.heroNumber);
          emit(DetailsLoaded(result: details!));
        }
        if (event is DetailsRefreshEvent) {
          emit(DetailsEmpty());
          emit(DetailsRefresh());
        }
      },
    );
  }
  final GetDetails getDetails;
}
