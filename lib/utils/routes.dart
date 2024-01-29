import 'package:flutter/material.dart';
import 'package:pocketpedia/pages/intro.dart';
import 'package:pocketpedia/pages/pokemon_detail.dart';
import 'package:pocketpedia/pages/pokemons_page.dart';
import 'package:pocketpedia/utils/app_routes.dart';

class Routes {
  final Map<String, Widget Function(BuildContext)> routesMap = {
    AppRoutes.intro: (ctx) => const Intro(),
    AppRoutes.pokemonPage: (ctx) => const PokemonsPage(),
    AppRoutes.pokemonDetail: (ctx) => const PokemonDetail(),
  };
  get routes {
    return routesMap;
  }

  get initialRoute {
    return AppRoutes.intro;
  }
}
