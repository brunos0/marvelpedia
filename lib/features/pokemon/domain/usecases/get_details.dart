import 'package:pocketpedia/core/error/failures.dart';
import 'package:pocketpedia/core/usecases/usecase_detail.dart';
import 'package:pocketpedia/features/pokemon/repositories/details_repository.dart';

class GetDetails implements UseCaseDetail<Record, NoParams> {
  const GetDetails(this.repository);
  final DetailsRepository repository;

  @override
  Future<(Record?, Failure?)> call(int pokemonNumber) async {
    return await repository.getDetails(pokemonNumber);
  }
}
