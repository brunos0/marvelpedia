import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pocketpedia/core/platfom/network_info.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remote_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remote_data_source_impl.dart';
import 'package:pocketpedia/features/pokemon/data/models/pokemons_model.dart';
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

  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter<Pokemons>(PokemonsAdapter());
  Hive.registerAdapter<Pokemon>(
      PokemonAdapter()); // Registre o adaptador para Pokemon aqui
  final pokemonsBox = await openBox<PokemonsModel>('pokemons');
  sl.registerSingleton<Box<PokemonsModel>>(pokemonsBox);
  sl.registerSingleton<HiveInterface>(Hive);

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
