/* spell-checker: disable */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketpedia/core/error/exceptions.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remore_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/models/pokemons_model.dart';

String tmdbApiKey = const String.fromEnvironment('API_KEY_TMDB');

class MoviesRemoteDataSourceImpl implements PokemonsRemoteDataSource {
  const MoviesRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<PokemonsModel?> getPokemons() async {
    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/discover/movie'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $tmdbApiKey'
        });
    if (response.statusCode == 200) {
      return (PokemonsModel.fromJson(json.decode(response.body)));
    } else {
      throw (ServerException());
    }
  }
}
