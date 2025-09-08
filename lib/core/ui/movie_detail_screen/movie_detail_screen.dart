import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/core/ui/movie_detail_screen/widgets/movie_detail_backdrop_widget.dart';
import 'package:vuiphim/core/ui/movie_detail_screen/widgets/movie_detail_header_info_widget.dart';
import 'package:vuiphim/core/ui/movie_detail_screen/widgets/movie_detail_overview_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailCubit>(
      create: (context) => MovieDetailCubit()..fetchMovieDetailFromId(movieId),
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            MovieDetailBackdropWidget(),
            CustomScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 75)),
                SliverToBoxAdapter(child: MovieDetailHeaderInfoWidget()),
                SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(child: MovieDetailOverviewWidget()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
