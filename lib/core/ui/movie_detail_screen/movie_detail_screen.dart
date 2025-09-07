import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/blocs/movie_detail/movie_detail_cubit.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (context) => MovieDetailCubit()..fetchMovieDetailFromId(movieId),
      child: Scaffold(body: Container()),
    );
  }
}
