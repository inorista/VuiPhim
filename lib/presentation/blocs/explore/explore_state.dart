part of 'explore_cubit.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<MovieEntity> movies;
  final bool isLoadingMore;
  const ExploreLoaded({this.movies = const [], this.isLoadingMore = false});

  ExploreLoaded copyWith({List<MovieEntity>? movies, bool? isLoadingMore}) {
    return ExploreLoaded(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [movies, isLoadingMore];
}

class ExploreError extends ExploreState {
  final String message;
  const ExploreError({required this.message});

  @override
  List<Object> get props => [message];
}
