import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/router/app_router.dart';
import 'package:vuiphim/presentation/blocs/explore/explore_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_animation_appbar.dart';
import 'package:vuiphim/presentation/utils/custom_button.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ExploreCubit()..loadNowPlayingMovies(),
      child: BlocListener<ExploreCubit, ExploreState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is ExploreLoaded) {
            scrollController.addListener(() {
              if (scrollController.offset >=
                      scrollController.position.maxScrollExtent &&
                  !scrollController.position.outOfRange) {
                context.read<ExploreCubit>().loadMoreNowPlayingMovies();
              }
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: height,
                  width: width,
                  child: BlocBuilder<ExploreCubit, ExploreState>(
                    builder: (context, state) {
                      if (state is ExploreLoaded) {
                        return CustomScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          slivers: [
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 120),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.all(10),
                              sliver: SliverList.separated(
                                itemCount: state.movies.length,
                                itemBuilder: (context, index) {
                                  final currentItem = state.movies[index];
                                  return InkWell(
                                    onTap: () {
                                      context.push(
                                        '/movie_detail/${currentItem.id}',
                                        extra: {
                                          'id': currentItem.id.toString(),
                                          'fromRoute': 'explore',
                                        },
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.white.withAlpha(100),
                                          width: 0.25,
                                        ),
                                      ),

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height: 270,
                                              fadeOutDuration: const Duration(
                                                microseconds: 1,
                                              ),
                                              fadeInDuration: const Duration(
                                                microseconds: 1,
                                              ),
                                              errorWidget:
                                                  (context, url, error) {
                                                    return const Shimmer(
                                                      height: 270,
                                                      width: double.infinity,
                                                      borderRadius: 0,
                                                      showLoading: false,
                                                    );
                                                  },
                                              imageUrl: currentItem.backdropUrl,
                                              placeholder: (context, url) =>
                                                  const Shimmer(
                                                    height: 270,
                                                    width: double.infinity,
                                                    borderRadius: 0,
                                                  ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              maxLines: 2,
                                              currentItem.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          currentItem.overview.isNotEmpty
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                    12.0,
                                                  ),
                                                  child: Text(
                                                    currentItem.overview,
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),

                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: CustomButton(
                                              borderRadius: 6,
                                              onTap: () {
                                                context.push(
                                                  '/movie_detail/${currentItem.id}',
                                                  extra: {
                                                    'id': currentItem.id
                                                        .toString(),
                                                    'fromRoute': 'explore',
                                                  },
                                                );
                                              },
                                              width: 130,
                                              color: Colors.white,
                                              borderColor: Colors.white,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,

                                                children: [
                                                  const Text(
                                                    "Xem thêm",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  SvgPicture.asset(
                                                    'assets/icons/arrow_right_icon.svg',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 20);
                                },
                              ),
                            ),

                            if (state.isLoadingMore)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/loading_icon.gif',
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 120),
                            ),
                          ],
                        );
                      } else if (state is ExploreLoading) {
                        return Image.asset(
                          'assets/icons/loading_icon.gif',
                          width: 30,
                        );
                      } else if (state is ExploreError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: CustomAnimationAppbar(
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      "Khám phá",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  actions: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        CupertinoIcons.arrow_down_to_line,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          context.push(AppRouter.search);
                        },
                        child: const Icon(
                          CupertinoIcons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                  scrollController: scrollController,
                  appBarHeight: Platform.isIOS ? 110 : 80,
                ),
              ),
            ], //
          ),
        ),
      ),
    );
  }
}
