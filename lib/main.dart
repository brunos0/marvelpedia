import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_bloc.dart';
import 'package:marvelpedia/injection_container.dart' as di;
import 'package:marvelpedia/injection_container.dart';
import 'package:marvelpedia/utils/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HeroesBloc>(
          lazy: false,
          create: (_) => sl<HeroesBloc>(),
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
