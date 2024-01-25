import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocketpedia/features/pokemon/data/models/pokemons_model.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/injection_container.dart' as di;
import 'package:pocketpedia/pages/pokemon_detail.dart';
import 'package:pocketpedia/pages/pokemons_favorites.dart';
import 'package:pocketpedia/pages/pokemons_page.dart';
import 'package:pocketpedia/pages/profile.dart';
import 'package:pocketpedia/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  //final box = di.sl<Box<Pokemons>>();
  //print(box.getAt(0));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade600)),
            ),
            appBarTheme: AppBarTheme(
                //shadowColor: Colors.red,
                color: Colors.green.shade800,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            primaryColor: Colors.green.shade800,
            colorScheme: ColorScheme.fromSwatch(
                accentColor: Colors.green.shade600,
                backgroundColor: Colors.white)),
        home: const PokemonsPage(),
        routes: {
          AppRoutes.pokemonPage: (ctx) => const PokemonsPage(),
          AppRoutes.pokemonDetail: (ctx) => PokemonDetail(),
          AppRoutes.pokemonFavorites: (ctx) => const PokemonsFavorites(),
          AppRoutes.profile: (ctx) => Profile(),
        });
  }
}
