import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/core/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/core/ui/utils/shimmer.dart';

class MovieDetailBackdropWidget extends StatelessWidget {
  const MovieDetailBackdropWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (_, state) {
        if (state is MovieDetailLoaded) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                child: CachedNetworkImage(
                  imageUrl: state.movieDetail.backdropUrl,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.425,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.45,
                      color: Colors.black.withAlpha(50),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is MovieDetailLoading) {
          return Shimmer(
            height: MediaQuery.of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.width,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
