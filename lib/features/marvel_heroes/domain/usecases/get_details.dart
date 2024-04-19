import 'package:marvelpedia/core/error/failures.dart';
import 'package:marvelpedia/core/usecases/usecase_detail.dart';
import 'package:marvelpedia/features/marvel_heroes/repositories/details_repository.dart';

class GetDetails implements UseCaseDetail<Record, NoParams> {
  const GetDetails(this.repository);
  final DetailsRepository repository;

  @override
  Future<(Record?, Failure?)> call(int heroNumber) async {
    return await repository.getDetails(heroNumber);
  }
}
