import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pocketpedia/core/platfom/network_info.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remore_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remore_data_source_impl.dart';
import 'package:pocketpedia/features/pokemon/data/repositories/pokemons_repository_impl.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/repositories/pokemons_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Number Trivia
// Bloc
  sl.registerFactory(() => PokemonsBloc(
        getPokemons: sl(),
      ));

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
