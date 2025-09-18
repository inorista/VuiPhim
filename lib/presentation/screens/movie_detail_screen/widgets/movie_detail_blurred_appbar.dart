import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/movie_infomation/movie_detail/movie_detail_cubit.dart';
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
            actions: [
              InkWell(
                onTap: () {
                  // On SHARE
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.share_up,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            scrollController: _scrollController,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
