import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source.dart';
import 'package:marvelpedia/features/marvel_heroes/data/datasources/heroes_remote_data_source_impl.dart';
import 'package:marvelpedia/features/marvel_heroes/data/repositories/details_repository_impl.dart';
import 'package:marvelpedia/features/marvel_heroes/data/repositories/heroes_repository_impl.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/hero.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/entities/heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/usecases/get_details.dart';
import 'package:marvelpedia/features/marvel_heroes/domain/usecases/get_heroes.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/details_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/presentation/bloc/heroes_bloc.dart';
import 'package:marvelpedia/features/marvel_heroes/repositories/details_repository.dart';
import 'package:marvelpedia/features/marvel_heroes/repositories/heroes_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:marvelpedia/core/platfom/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc
  sl.registerFactory<HeroesBloc>(() => HeroesBloc(
        getHeroes: sl(),
      ));

  int value = 0;
  sl.registerFactory<DetailsBloc>(
    () => DetailsBloc(
      getDetails: sl(),
    ),
  );
// Register Hive

  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  Hive.registerAdapter<Heroes>(HeroesAdapter());
  Hive.registerAdapter<Hero>(HeroAdapter());
  final pokemonsBox = await openBox<Heroes>('heroes');

  sl.registerSingleton<Box<Heroes>>(pokemonsBox);
  sl.registerSingleton<HiveInterface>(Hive);

// Use Cases
  sl.registerLazySingleton<GetHeroes>(() => GetHeroes(sl()));
  sl.registerLazySingleton<GetDetails>(() => GetDetails(sl()));

// Repository
  sl.registerLazySingleton<HeroesRepository>(() => HeroesRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<DetailsRepository>(() => DetailsRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

// Data Sources
  sl.registerLazySingleton<HeroesRemoteDataSource>(
      () => HeroesRemoteDataSourceImpl(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}

Future<Box<T>> openBox<T>(String boxName) async {
  return await Hive.openBox<T>(boxName);
}
