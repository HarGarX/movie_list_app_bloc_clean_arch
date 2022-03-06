// import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_list_app_bloc/features/bottom_nav_bar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:movie_list_app_bloc/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_list_app_bloc/features/watch/data/datasources/movie_remote_data_source.dart';
import 'package:movie_list_app_bloc/features/watch/domain/repositories/movie_repository.dart';
import 'package:movie_list_app_bloc/features/watch/domain/usecases/get_up_coming_movies.dart';
import 'package:movie_list_app_bloc/features/watch/presentation/bloc/watch_bloc.dart';

import '../../features/watch/data/repositories/movie_repository_impl.dart';
import '../api/api_client.dart';

final GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  //! Bloc

  locator.registerFactory<BottomNavBarBloc>(
    () => BottomNavBarBloc(),
  );
  locator.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
  locator.registerFactory<WatchBloc>(
    () => WatchBloc(
      getUpComingMoviesUseCase: locator(),
    ),
  );
  //! Usecases
  locator.registerLazySingleton<GetUpComingMoviesUseCase>(
    () => GetUpComingMoviesUseCase(
      movieRepository: locator(),
    ),
  );

  //! Repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  //! Remote datasource
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  //! Local datasource

  //! Core
  // locator.registerLazySingleton<NetworkInfo>(
  //   () => new NetworkInfoImpl(locator()),
  // );

  locator.registerLazySingleton<http.Client>(() => http.Client());

  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(locator()),
  );

  //! External
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  // locator.registerLazySingleton<DataConnectionChecker>(
  //   () => new DataConnectionChecker(),
  // );
}
