/* spell-checker: disable */

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source.dart';
import 'package:marvelpedia/features/marvel_heroes/data/models/heroes_model.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/core/error/exceptions.dart';
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source.dart';
import 'package:marvelpedia/features/marvel_heroes/data/models/heroes_model.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/injection_container.dart' as di;

String tmdbApiKey = const String.fromEnvironment('API_KEY_TMDB');

class HeroesRemoteDataSourceImpl implements HeroesRemoteDataSource {
  const HeroesRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<HeroesModel?> getHeroes() async {
    //
    final box = di.sl<Box<Heroes>>();
    if (box.isEmpty) {
      final response = await client.get(Uri.parse(''),
          /*
              'https://gateway.marvel.com:443/v1/public/characters?apikey=
              21c85811356ee6d25c73d915dcbedf89
              &hash=
              d750e07c81adc67e293588dac6df2f51
              &ts=1&limit=50&offset=0'),
              */
          //'https://pokeapi.co/api/v2/pokemon?offset=0&limit=151'), //2000
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          });

      if (response.statusCode == 200) {
        final mhModel = HeroesModel.fromJson(json.decode(response.body));
        if (mhModel.step == 1) {
          final listSize = mhModel.heroes.length;
          for (int i = 0; i < listSize; i++) {
            final response = await client.get(
                Uri.parse(
                  'https://pokeapi.co/api/v2/pokemon/${mhModel.heroes[i].name.trim()}',
                ),
                headers: {
                  'Content-Type': 'application/json; charset=utf-8',
                });
            if (response.statusCode == 200) {
              //
              String description =
                  mhModel.detailsFromJson(json.decode(response.body));
              mhModel.heroes[i].description = description;
              /*//abilities;
              pkModel.pokemons[i].moves = moves;
              pkModel.pokemons[i].weight = weight;
              pkModel.pokemons[i].height = height;
              pkModel.pokemons[i].types = types;
              pkModel.pokemons[i].stats = stats;
              */
              mhModel.step = 2;
            }
          }
        }

        box.add(mhModel);

        return mhModel;
      } else {
        throw (ServerException());
      }
    } else {
      return HeroesModel(
          heroes: di.sl<Box<Heroes>>().getAt(0)!.heroes, step: 1);
    }
  }

  @override
  Future<(List evolutions, String description, String genus)> getDetail(
      int index) async {
    final pokemonNumber = di.sl<Box<Heroes>>().getAt(0)!.heroes[index].id;
    final response = await client.get(
        Uri.parse(
            'https://pokeapi.co/api/v2/pokemon-species/$pokemonNumber'), //9999999
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        });
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final evolutionChain = result["evolution_chain"]["url"];
      final evolutionChainId = evolutionChain
          .split("https://pokeapi.co/api/v2/evolution-chain/")[1]
          .replaceAll('/', '');
      final description = result['flavor_text_entries'][9]['flavor_text']
          .replaceAll('\n', ' ') as String;
      final category =
          result['genera'][7]['genus'].replaceAll(' Pokémon', '') as String;
      return (['1', '2', '3'], description, category);
    } else {
      return ([], '', '');
    }
  }
}
