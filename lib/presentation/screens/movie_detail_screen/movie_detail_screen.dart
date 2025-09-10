import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/widgets/movie_detail_backdrop_widget.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/widgets/movie_detail_blurred_appbar.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/widgets/movie_detail_header_info_widget.dart';
import 'package:vuiphim/presentation/screens/movie_detail_screen/widgets/movie_detail_overview_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return BlocProvider<MovieDetailCubit>(
      create: (context) => MovieDetailCubit()..fetchMovieDetailFromId(movieId),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            const MovieDetailBackdropWidget(),
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: const [
                SliverToBoxAdapter(child: SizedBox(height: 75)),
                SliverToBoxAdapter(child: MovieDetailHeaderInfoWidget()),
                SliverToBoxAdapter(child: MovieDetailOverviewWidget()),
              ],
            ),
            MovieDetailBlurredAppBar(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
