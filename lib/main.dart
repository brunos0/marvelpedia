import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/injection_container.dart' as di;
import 'package:pocketpedia/injection_container.dart';
import 'package:pocketpedia/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PokemonsBloc>(
          lazy: false,
          create: (_) => sl<PokemonsBloc>(),
        ),
        BlocProvider<DetailsBloc>(
          lazy: false,
          create: (_) => sl<DetailsBloc>(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes().initialRoute,
      routes: Routes().routes,
    );
  }
}
