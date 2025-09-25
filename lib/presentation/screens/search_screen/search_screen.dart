import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
import 'package:vuiphim/core/utils/enum.dart';
import 'package:vuiphim/presentation/blocs/movie_search/movie_search_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_search_appbar.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieSearchCubit()..getPlayingNowMovies(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomSearchAppbar(
          controller: _searchController,
          onChanged: (p0) {},
          onFieldSubmitted: (p0) {},
          textFieldHeight: 38.0,
          appbarHeight: 55.0,
          hintText: 'Tìm kiếm phim, TV show...',
        ),
        body: BlocBuilder<MovieSearchCubit, MovieSearchState>(
          builder: (context, state) {
            if (state is MovieSearchLoading) {
              return Center(
                child: Image.asset('assets/icons/loading_icon.gif'),
              );
            } else if (state is MovieSearchLoaded) {
              return CustomScrollView(
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Phim được đề xuất cho bạn',
                        style: TextStyle(
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
                                  fadeInDuration: const Duration(
                                    milliseconds: 10,
                                  ),
                                  fadeOutDuration: const Duration(
                                    milliseconds: 10,
                                  ),
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
              // return ListView.builder(
              //   itemCount: state.movies.length,
              //   itemBuilder: (context, index) {
              //     final movie = state.movies[index];
              //     return ListTile(
              //       title: Text(
              //         movie.title,
              //         style: const TextStyle(color: Colors.white),
              //       ),
              //     );
              //   },
              // );
            } else if (state is MovieSearchError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
