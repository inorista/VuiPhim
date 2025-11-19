import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/select_movie_episode/select_movie_episode_cubit.dart';
import 'package:vuiphim/presentation/utils/custom_button.dart';
import 'package:vuiphim/presentation/utils/download_widget.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return BlocBuilder<SelectMovieEpisodeCubit, SelectMovieEpisodeState>(
      builder: (context, state) {
        if (state.status == SelectMovieEpisodeStatus.success &&
            state.sources.isNotEmpty) {
          return CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 150)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10,
                  ),
                  child: Text(
                    "Tổng số tập: ${state.sources.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SliverList.builder(
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
                          episode.episode.serverName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, dataIndex) {
                              final currentSourceData =
                                  episode.serverDatas[dataIndex];
                              return Row(
                                children: [
                                  DownloadButtonWidget(
                                    movieId: episode.episode.movieId,
                                    videoId: currentSourceData.episodeId ?? '',
                                    m3u8Url: currentSourceData.linkM3U8 ?? '',
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      onTap: () {},
                                      height: 50,
                                      color: Colors.transparent,
                                      child: Text(
                                        currentSourceData.name ?? '',
                                        style: const TextStyle(
                                          color: Color(0xFFbe2b27),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: episode.serverDatas.length,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 14);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
