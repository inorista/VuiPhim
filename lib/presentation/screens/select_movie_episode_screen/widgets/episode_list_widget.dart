import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/router/app_router.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/presentation/blocs/select_movie_episode/select_movie_episode_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_button.dart';

class EpisodeListWidget extends StatelessWidget {
  final MovieDetailEntity movieDetail;
  const EpisodeListWidget({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectMovieEpisodeCubit, SelectMovieEpisodeState>(
      builder: (context, state) {
        return switch (state.status) {
          SelectMovieEpisodeStatus.loading => SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: CircularProgressIndicator(color: Colors.red.shade900),
            ),
          ),
          SelectMovieEpisodeStatus.failure => const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Error loading episodes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SelectMovieEpisodeStatus.success =>
            state.sources.isEmpty
                ? const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'No episodes available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : SliverList.builder(
                    itemCount: state.sources.length,
                    itemBuilder: (context, index) {
                      final episode = state.sources[index];
                      return Padding(
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
                            // SizedBox(
                            //   height: 50,
                            //   child: ListView.separated(
                            //     physics: const BouncingScrollPhysics(
                            //       parent: AlwaysScrollableScrollPhysics(),
                            //     ),
                            //     scrollDirection: Axis.horizontal,
                            //     itemBuilder: (context, dataIndex) {
                            //       final currentSourceData =
                            //           episode.serverData[dataIndex];
                            //       return CustomButton(
                            //         onTap: () {
                            //           context.push(
                            //             AppRouter.videoPlayer,
                            //             extra: {
                            //               'movieDetail': movieDetail,
                            //               'serverData': currentSourceData,
                            //             },
                            //           );
                            //         },
                            //         width: 65,
                            //         height: 50,
                            //         color: Colors.transparent,
                            //         child: Text(
                            //           currentSourceData.name ?? '',
                            //           style: const TextStyle(
                            //             color: Color(0xFFbe2b27),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //     itemCount: episode.serverData.length,
                            //     separatorBuilder: (context, index) {
                            //       return const SizedBox(width: 10);
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
