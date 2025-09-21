import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
import 'package:vuiphim/core/utils/enum.dart';
import 'package:vuiphim/presentation/blocs/home/popular_movie/popular_movie_cubit.dart';
import 'package:vuiphim/core/constants/app_text.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class PopularMovieWidget extends StatelessWidget {
  const PopularMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final popularScrollControler = ScrollController();
    return Padding(
      padding: const EdgeInsets.only(top: 65),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: BlocBuilder<PopularMovieCubit, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoaded) {
              final movies = state.movies;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.horizontal,
                controller: popularScrollControler,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      VibrationNative.impactFeedback(VibrateStyle.medium.name);
                      context.push('/movie_detail/${movie.id}');
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SizedBox(
                            height: height * 0.9,
                            width: width * 0.9,
                            child: CachedNetworkImage(
                              imageUrl: movie.backdropUrl,
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 10),
                              fadeOutDuration: const Duration(milliseconds: 10),
                              placeholder: (context, url) => Shimmer(
                                height: height * 0.9,
                                width: width * 0.9,
                              ),
                              errorWidget: (context, url, error) => Shimmer(
                                height: height * 0.9,
                                width: width * 0.9,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              movie.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffff7b7b).withAlpha(200),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  AppText.trending,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 7),
                                SvgPicture.asset(
                                  'assets/icons/trending-up.svg',
                                  width: 16,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                // Icon(LineIcon.down)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
              );
            } else if (state is PopularMovieLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
