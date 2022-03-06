import 'dart:async';
import 'dart:io';

import '../../../../../core/api/api_client.dart';
import '../../../../core/constants/error_consts.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getUpComingMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient client;
  MovieRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<List<MovieModel>> getUpComingMovies() async {
    try {
      final response =
          await client.get('https://api.themoviedb.org/3/movie/upcoming?');
      print("FROM REMOTE DATA SOURCE ------------ \n  $response");
      if (response != null) {
        return response;
      }
      throw const ServerException(errorMessage: ErrorConst.UNKNOWN_ERROR);
    } on TimeoutException {
      rethrow;
    } on SocketException {
      rethrow;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
