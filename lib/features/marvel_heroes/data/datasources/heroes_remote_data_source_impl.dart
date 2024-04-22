/* spell-checker: disable */

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source.dart';
import 'package:marvelpedia/features/marvel_heroes/data/models/heroes_model.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/core/error/exceptions.dart';
import 'package:marvelpedia/injection_container.dart' as di;

String publicKey = const String.fromEnvironment('PUBLIC_KEY');
String hash = const String.fromEnvironment('HASH');

class HeroesRemoteDataSourceImpl implements HeroesRemoteDataSource {
  const HeroesRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<HeroesModel?> getHeroes(bool increment) async {
    //
    final box = di.sl<Box<Heroes>>();
    if (box.isEmpty || increment) {
      int offsetHero = 0;

      if (increment) {
        offsetHero = di.sl<Box<Heroes>>().getAt(0)!.heroes.length;
      }
      final response = await client.get(
          Uri.parse(
              '''https://gateway.marvel.com:443/v1/public/characters?orderBy=name&apikey='''
              '''$publicKey&hash=$hash&ts=1&limit=100&offset=$offsetHero'''),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          });

      if (response.statusCode == 200) {
        final mhModel = HeroesModel.fromJson(json.decode(response.body));

        if (increment) {
          final heroes = box.getAt(0)!.heroes;
          heroes.addAll(mhModel.heroes);
          final updatedHeroes = Heroes(heroes: heroes, step: 1);
          await box.putAt(0, updatedHeroes);
        } else {
          box.add(mhModel);
        }

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
