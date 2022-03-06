import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/usecases/usecase.dart';
import '../../../../core/models/movie_model.dart';
import '../../domain/usecases/get_up_coming_movies.dart';

part 'watch_event.dart';
part 'watch_state.dart';

class WatchBloc extends Bloc<WatchEvent, WatchState> {
  // UseCase
  final GetUpComingMoviesUseCase getUpComingMoviesUseCase;
  WatchBloc({required this.getUpComingMoviesUseCase}) : super(WatchInitial()) {
    on<WatchEvent>((event, emit) async {
      if (event is LoadUpcomingMoviesEvent) {
        await _getUpComingMoviesMapingEventToState(event, emit);
      }
    });
  }
  Future<void> _getUpComingMoviesMapingEventToState(
    WatchEvent event,
    Emitter<WatchState> emit,
  ) async {
    emit(WatchLoading());
    final _eitherFailureOrData = await getUpComingMoviesUseCase(NoParams());

    _eitherFailureOrData.fold((failure) => _mapFailureToState(failure, emit),
        (response) async {
      print(response);
      print('GAFAR $response');
      emit(WatchSuccess(movieModel: response));
    });
  }

  Future<void> _mapFailureToState(
    Failure failure,
    Emitter<WatchState> emit,
  ) async {
    print("GAFAR ALWAYS KNOWS");
    switch (failure.runtimeType) {
      case NoInternetFailure:
        emit(WatchFailed(errorMessage: failure.message));
        break;
      case ServerFailure:
        emit(WatchFailed(errorMessage: failure.message));
        break;
      case TimeoutFailure:
        emit(WatchFailed(errorMessage: failure.message));
        break;
      case UnknownFailure:
        emit(WatchFailed(errorMessage: failure.message));
        break;
      default:
        emit(WatchFailed(errorMessage: failure.message));
        break;
    }
  }
}
