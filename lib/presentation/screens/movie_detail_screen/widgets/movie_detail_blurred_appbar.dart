import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';

class MovieDetailBlurredAppBar extends StatelessWidget {
  const MovieDetailBlurredAppBar({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoaded) {
          return CustomAnimationAppbar(
            title: state.movieDetail.title,
            scrollController: _scrollController,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
