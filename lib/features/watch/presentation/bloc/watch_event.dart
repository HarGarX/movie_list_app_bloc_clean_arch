part of 'watch_bloc.dart';

abstract class WatchEvent extends Equatable {
  const WatchEvent();

  @override
  List<Object> get props => [];
}

class LoadUpcomingMoviesEvent extends WatchEvent {}
