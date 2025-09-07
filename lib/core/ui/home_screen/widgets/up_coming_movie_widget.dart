import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:vuiphim/core/blocs/home/upcoming_movie/upcoming_movie_cubit.dart';
import 'package:vuiphim/core/constants/app_text.dart';

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
                      return Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              movies[index].posterUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: movies.length,
                  ),
                );
              } else if (state is UpcomingMovieLoading) {
                return const Center(child: CupertinoActivityIndicator());
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
