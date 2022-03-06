import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/usecases/usecase.dart';
import '../../../../core/models/movie_model.dart';
import '../repositories/movie_repository.dart';

class GetUpComingMoviesUseCase extends UseCase<List<MovieModel>, NoParams> {
  final MovieRepository movieRepository;
  GetUpComingMoviesUseCase({
    required this.movieRepository,
  });
  @override
  Future<Either<Failure, List<MovieModel>>> call(NoParams params) async {
    return await movieRepository.getUpComingMovies();
  }
}
