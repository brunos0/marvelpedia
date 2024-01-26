import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketpedia/core/platfom/network_info.dart';
import 'package:pocketpedia/core/usecases/usecase.dart';
import 'package:pocketpedia/core/usecases/usecase_detail.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remote_data_source.dart';
import 'package:pocketpedia/features/pokemon/data/datasources/pokemons_remote_data_source_impl.dart';
import 'package:pocketpedia/features/pokemon/data/repositories/details_repository_impl.dart';
import 'package:pocketpedia/features/pokemon/data/repositories/pokemons_repository_impl.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemon.dart';
import 'package:pocketpedia/features/pokemon/domain/entities/pokemons.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_details.dart';
import 'package:pocketpedia/features/pokemon/domain/usecases/get_pokemons.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/details_bloc.dart';
import 'package:pocketpedia/features/pokemon/presentation/bloc/pokemons_bloc.dart';
import 'package:pocketpedia/features/pokemon/repositories/details_repository.dart';
import 'package:pocketpedia/features/pokemon/repositories/pokemons_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc
  sl.registerFactory<PokemonsBloc>(() => PokemonsBloc(
        getPokemons: sl(),
      ));

  int value = 0;
  sl.registerFactory<DetailsBloc>(
    () => DetailsBloc(
      getDetails: sl(),
      pokemonNumber: value,
    ),
  );
// Register Hive

  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter<Pokemons>(PokemonsAdapter());
  Hive.registerAdapter<Pokemon>(PokemonAdapter());
  final pokemonsBox = await openBox<Pokemons>('pokemons');

  sl.registerSingleton<Box<Pokemons>>(pokemonsBox);
  sl.registerSingleton<HiveInterface>(Hive);

// Use Cases
  sl.registerLazySingleton<GetPokemons>(() => GetPokemons(sl()));
  sl.registerLazySingleton<GetDetails>(() => GetDetails(sl()));

  // sl.registerLazySingleton<UseCaseDetail>(() => GetDetails(sl()));
// Repository
  sl.registerLazySingleton<PokemonsRepository>(() => PokemonsRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<DetailsRepository>(() => DetailsRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

// Data Sources
  sl.registerLazySingleton<PokemonsRemoteDataSource>(
      () => PokemonsRemoteDataSourceImpl(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}

Future<Box<T>> openBox<T>(String boxName) async {
  return await Hive.openBox<T>(boxName);
}
