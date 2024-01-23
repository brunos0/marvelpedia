/* spell-checker: disable */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pocketpedia/core/error/exceptions.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remore_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/models/pokemons_model.dart';

String tmdbApiKey = const String.fromEnvironment('API_KEY_TMDB');

class PokemonsRemoteDataSourceImpl implements PokemonsRemoteDataSource {
  const PokemonsRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<PokemonsModel?> getPokemons() async {
    final response = await client.get(
        Uri.parse(
            'https://pokeapi.co/api/v2/pokemon?offset=0&limit=20'), //9999999
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        });
    if (response.statusCode == 200) {
      final pkModel = PokemonsModel.fromJson(json.decode(response.body));
      if (pkModel.step == 1) {
        final listSize = pkModel.pokemons.length;
        for (int i = 0; i < listSize; i++) {
          final response = await client.get(
              Uri.parse(
                'https://pokeapi.co/api/v2/pokemon/${pkModel.pokemons[i].name.trim()}',
              ), //9999999
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
              });
          if (response.statusCode == 200) {
            //
            List<String> abilities;
            List<Map<String, dynamic>> stats;
            List<String> moves;
            List<String> types;
            double weight;
            double height;
            (abilities, stats, moves, weight, height, types) =
                pkModel.detailsFromJson(json.decode(response.body));
            pkModel.pokemons[i].abilities = abilities;
            pkModel.pokemons[i].moves = moves;
            pkModel.pokemons[i].weight = weight;
            pkModel.pokemons[i].height = height;
            pkModel.pokemons[i].types = types;
            pkModel.pokemons[i].stats = stats;
            pkModel.step = 2;
          }
        }
      }
      return pkModel;
    } else {
      throw (ServerException());
    }
  }
}
