import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/injection_container.dart' as di;
import 'package:pocketpedia/injection_container.dart';
import 'package:pocketpedia/pages/pokemon_detail.dart';
import 'package:pocketpedia/pages/pokemons_page.dart';

import 'package:pocketpedia/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
        home: MultiBlocProvider(
            //
            providers: [
              BlocProvider<PokemonsBloc>(
                // lazy: false,
                create: (_) => sl<PokemonsBloc>(),
              ),
              BlocProvider<DetailsBloc>(
                //lazy: false,
                create: (_) => sl<DetailsBloc>(),
              )
            ],

            // Top half
            child: const PokemonsPage()),
        routes: {
          AppRoutes.pokemonPage: (ctx) => const PokemonsPage(),
          AppRoutes.pokemonDetail: (ctx) => PokemonDetail(),
        });
  }
}
