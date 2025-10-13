import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/home/popular_movie/popular_movie_cubit.dart';

class BackdropWidget extends StatelessWidget {
  final double height;

  const BackdropWidget({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return SizedBox(
      width: double.infinity,
      height: height * 0.5,
      child: BlocBuilder<PopularMovieCubit, PopularMovieState>(
        builder: (context, state) {
          if (state is PopularMovieLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is PopularMovieLoaded) {
            final movie = state.movies[random.nextInt(state.movies.length)];
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                CachedNetworkImage(
                  imageUrl: movie.backdropUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height * 0.5,
                  fadeInDuration: const Duration(milliseconds: 10),
                  fadeOutDuration: const Duration(milliseconds: 10),
                  errorWidget: (context, url, error) => const SizedBox(),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      height: height * 0.55,
                      width: double.infinity,
                      color: Colors.black.withAlpha(5),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
