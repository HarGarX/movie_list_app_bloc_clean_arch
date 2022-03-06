import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/error_consts.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/models/genre_model.dart';
import '../../../../core/models/movie_model.dart';
import '../../../../core/models/movie_video_model.dart';
import '../../../../core/models/search_result_model.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  MovieRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<MovieVideoModel>>> getMovieVideosById(
      {required int movieId}) {
    // TODO: implement getMovieVideosById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<GenreModel>>> getMoviesGenre() {
    // TODO: implement getMoviesGenre
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getUpComingMovies() async {
    try {
      final remoteData = await remoteDataSource.getUpComingMovies();
      return Right(remoteData);
    } on TimeoutException {
      return Left(TimeoutFailure(errorMessage: ErrorConst.TIMEOUT_MESSAGE));
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    } on SocketException {
      return Left(NoInternetFailure());
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultModel>>> searchMovieByTerm(
      {required String searchTerm}) {
    // TODO: implement searchMovieByTerm
    throw UnimplementedError();
  }
}
