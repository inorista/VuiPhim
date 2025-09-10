import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vuiphim/core/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class MovieDetailHeaderInfoWidget extends StatelessWidget {
  const MovieDetailHeaderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: state.movieDetail.posterUrl,
                        width: 150,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.movieDetail.title,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/time_icon.svg',
                              width: 18,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                "Thời lượng: ${state.movieDetail.runtime} phút",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/imdb_logo.png',
                              width: 35,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${state.movieDetail.voteAverage.toStringAsFixed(2)}/10",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Shimmer(
              height: 220,
              width: MediaQuery.of(context).size.width,
            );
          }
        },
      ),
    );
  }
}
