part of 'watch_bloc.dart';

abstract class WatchState extends Equatable {
  const WatchState();

  @override
  List<Object> get props => [];
}

class WatchInitial extends WatchState {}

class WatchLoading extends WatchState {}

class WatchSuccess extends WatchState {
  final List<MovieModel> movieModel;
  const WatchSuccess({
    required this.movieModel,
  });
}

class WatchFailed extends WatchState {
  final String errorMessage;
  const WatchFailed({
    required this.errorMessage,
  });
}
