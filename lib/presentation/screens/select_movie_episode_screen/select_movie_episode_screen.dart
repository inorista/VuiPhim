import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/router/app_router.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/presentation/utils/custom_button.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class SelectMovieEpisodeScreen extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const SelectMovieEpisodeScreen({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: movieDetail.backdropUrl,
                  height: height * 0.35,
                  placeholder: (context, url) =>
                      Shimmer(height: height * 0.35, width: width),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 1),
                  fadeOutDuration: const Duration(milliseconds: 1),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            "Phim: ${movieDetail.title}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ...movieDetail.episodes.map(
                        (episode) => SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode.serverName ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  height: 50,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, dataIndex) {
                                      final currentSourceData =
                                          episode.serverData[dataIndex];
                                      return CustomButton(
                                        onTap: () {
                                          context.push(
                                            AppRouter.videoPlayer,
                                            extra: currentSourceData,
                                          );
                                        },
                                        width: 65,
                                        height: 50,
                                        color: Colors.transparent,
                                        child: Text(
                                          currentSourceData.name ?? '',
                                          style: const TextStyle(
                                            color: Color(0xFFbe2b27),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: episode.serverData.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(width: 10);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SliverList.separated(
                      //   itemBuilder: (context, index) {
                      //     final episode = movieDetail.episodes[index];
                      //     return SizedBox(
                      //       height: 70,
                      //       child: ListView.builder(
                      //         itemCount: episode.serverData.length,
                      //         itemBuilder: (context, episodeIndex) {
                      //           final currentEpisode =
                      //               episode.serverData[episodeIndex];
                      //           return ListTile(
                      //             title: Text(
                      //               currentEpisode.name ?? '',
                      //               style: const TextStyle(color: Colors.white),
                      //             ),
                      //             onTap: () {
                      //               // Handle episode selection
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     );
                      //   },
                      //   itemCount: movieDetail.episodes.length,
                      //   separatorBuilder: (context, index) {
                      //     return const SizedBox(height: 10);
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 10,
              top: 10,
              child: InkWell(
                onTap: () {
                  context.pop();
                },
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(150),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(CupertinoIcons.back, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
