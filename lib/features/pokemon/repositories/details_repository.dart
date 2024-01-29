import 'package:pocketpedia/core/error/failures.dart';

abstract class DetailsRepository {
  DetailsRepository();

  Future<(Record?, Failure?)> getDetails(int pokemonNumber);
}
