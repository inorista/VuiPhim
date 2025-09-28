import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
import 'package:vuiphim/presentation/blocs/movie_search/movie_search_cubit.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class SearchBodyWidget extends StatelessWidget {
  final MovieSearchState state;
  const SearchBodyWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is MovieSearchLoading) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (state is MovieSearchLoaded) {
      final state = this.state as MovieSearchLoaded;
      final movies = state.nowPlayingMovies;
      final searchedMovies = state.searchedMovies;
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                searchedMovies.isEmpty
                    ? 'Phim được đề xuất cho bạn'
                    : 'Kết quả gần nhất',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            sliver: SliverList.separated(
              addAutomaticKeepAlives: true,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return InkWell(
                  onTap: () {
                    VibrationNative.vibrateWithIntensity(1);
                    context.push('/movie_detail/${movie.id}');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          imageUrl: movie.backdropUrl,
                          fit: BoxFit.cover,
                          width: 130,
                          height: 75,
                          placeholderFadeInDuration: const Duration(
                            milliseconds: 10,
                          ),
                          placeholder: (context, url) {
                            return const Shimmer(
                              width: 130,
                              height: 75,
                              borderRadius: 6,
                            );
                          },
                          fadeInDuration: const Duration(milliseconds: 10),
                          fadeOutDuration: const Duration(milliseconds: 10),
                          errorWidget: (context, url, error) =>
                              const SizedBox(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          movie.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xfff1f1f1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        CupertinoIcons.play_circle,
                        color: Colors.white,
                        size: 44,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 14);
              },
            ),
          ),
        ],
      );
    } else if (state is MovieSearchError) {
      final state = this.state as MovieSearchError;
      return Center(
        child: Text(state.message, style: const TextStyle(color: Colors.white)),
      );
    } else {
      return const SizedBox();
    }
  }
}
