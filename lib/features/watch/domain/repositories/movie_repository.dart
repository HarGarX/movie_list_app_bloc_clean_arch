import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/models/genre_model.dart';
import '../../../../core/models/movie_model.dart';
import '../../../../core/models/movie_video_model.dart';
import '../../../../core/models/search_result_model.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieModel>>> getUpComingMovies();
  Future<Either<Failure, List<GenreModel>>> getMoviesGenre();
  Future<Either<Failure, List<MovieVideoModel>>> getMovieVideosById(
      {required int movieId});
  Future<Either<Failure, List<SearchResultModel>>> searchMovieByTerm(
      {required String searchTerm});
}
