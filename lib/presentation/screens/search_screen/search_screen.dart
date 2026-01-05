import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/native/vibration_native.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(onScroll);
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    final cubit = context.read<MovieSearchCubit>();
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 20 &&
        !_scrollController.position.outOfRange) {
      if (cubit.state.status == MovieSearchStatus.success &&
          cubit.state.isSearching) {
        final keyword = _searchController.text;
        if (keyword.isNotEmpty) {
          cubit.searchMoreMovies(keyword);
        }
      } else if (cubit.state.status == MovieSearchStatus.success &&
          !cubit.state.isSearching) {
        cubit.loadMoreNowPlayingMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomSearchAppbar(
        controller: _searchController,
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<MovieSearchCubit>().resetSearch();
          } else {
            context.read<MovieSearchCubit>().searchMovies(value);
          }
        },
        onFieldSubmitted: (value) {},
        textFieldHeight: 38.0,
        appbarHeight: 55.0,
        hintText: 'Tìm kiếm phim, TV show...',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
          builder: (context, state) {
            if (state.status == MovieSearchStatus.loading) {
              return Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white.withAlpha(150),
                  radius: 15,
                ),
              );
            } else if (state.status == MovieSearchStatus.success) {
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  if (state.isSearching) ...[
                    if (state.searchedMovies.isNotEmpty) ...[
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Kết quả gần nhất',
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
                          itemCount: state.searchedMovies.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 14);
                          },
                          itemBuilder: (context, index) {
                            final movie = state.searchedMovies[index];
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
                        ),
                      ),
                    ] else ...[
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/search_icon.svg',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 12),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Không tìm thấy kết quả cho từ khóa ',
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(150),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '"${_searchController.text}"',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                  if (!state.isSearching && state.searchedMovies.isEmpty) ...[
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
                        itemCount: state.nowPlayingMovies.length,
                        itemBuilder: (context, index) {
                          final movie = state.nowPlayingMovies[index];
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
                ],
              );
            } else if (state.status == MovieSearchStatus.failure) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Unknown error',
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
