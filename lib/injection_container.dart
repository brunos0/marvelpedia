import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pocketpedia/core/platfom/network_info.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remote_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remote_data_source_impl.dart';
import 'package:pocketpedia/features/pokemon/data/repositories/pokemons_repository_impl.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';
//import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/repositories/pokemons_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc
  sl.registerFactory(() => PokemonsBloc(
        getPokemons: sl(),
      ));

// Register Hive
  sl.registerSingleton<HiveInterface>(Hive);

/*
  // Create a box collection
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  final collection = await BoxCollection.open(
      'Pokepedia', // Name of your database
      {'pokemons'}, // Names of your boxes
      path: directory.path
      //     './', // Path where to store your boxes (Only used in Flutter / Dart IO)
      //key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
      );

  // Open your boxes. Optional: Give it a type.
  final pokemonsBox = await collection.openBox<List<Pokemon>>('pokemons');

  // Register the box with GetIt
  sl.registerSingleton<BoxCollection<List<Pokemon>>>(pokemonsBox);

  final pokemonsBox = await collection.openBox<List<Pokemon>>('pokemons');

  // Register the box with GetIt
  sl.registerSingleton<Box<List<Pokemon>>>(pokemonsBox);
  //sl.registerSingleton<Box<List<Pokemon>>>('pokemons');

  sl.registerSingleton<HiveInterface>(Hive);
  sl.registerLazySingleton(() => Hive.box<Pokemons>('pokemons'));
*/
// Use Cases
  sl.registerLazySingleton(() => GetPokemons(sl()));

// Repository
  sl.registerLazySingleton<PokemonsRepository>(() => PokemonsRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

// Data Sources
  sl.registerLazySingleton<PokemonsRemoteDataSource>(
      () => PokemonsRemoteDataSourceImpl(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}

Future<Box<T>> openBox<T>(String boxName) async {
  return await Hive.openBox<T>(boxName);
}
