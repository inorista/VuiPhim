import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
import 'package:vuiphim/presentation/blocs/home/upcoming_movie/upcoming_movie_cubit.dart';
import 'package:vuiphim/core/constants/app_text.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class UpComingMovieWidget extends StatelessWidget {
  const UpComingMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      color: Colors.black,
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                AppText.upcoming,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/icons/trending-up.svg',
                width: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xffff7b7b),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<UpcomingMovieCubit, UpcomingMovieState>(
            builder: (context, state) {
              if (state is UpcomingMovieLoaded) {
                final movies = state.movies;
                return SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          VibrationNative.vibrateWithIntensity(1);
                          context.push(
                            '/movie_detail/${movies[index].id}',
                            extra: {'id': movies[index].id.toString()},
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: CachedNetworkImage(
                            imageUrl: movies[index].posterUrl,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 10),
                            fadeOutDuration: const Duration(milliseconds: 10),
                            width: 170,
                            placeholder: (context, url) =>
                                const Shimmer(width: 170, height: 220),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 15);
                    },
                    itemCount: movies.length,
                  ),
                );
              } else if (state is UpcomingMovieLoading) {
                return const SizedBox(height: 250);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
