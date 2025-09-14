import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cubit.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_state.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/widgets/controls_overlay.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/widgets/video_player_progress_indicator.dart';

class VideoPlayerScreen extends StatelessWidget {
  final ServerDataEntity serverData;
  final MovieDetailEntity movieDetail;

  const VideoPlayerScreen({
    super.key,
    required this.serverData,
    required this.movieDetail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VideoPlayerCubit()..initializeVideo(serverData.linkM3U8 ?? ''),
      child: VideoPlayerView(movieDetail: movieDetail),
    );
  }
}

class VideoPlayerView extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const VideoPlayerView({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          context.read<VideoPlayerCubit>().dispose();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoPlayerLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state is VideoPlayerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (state is VideoPlayerReady) {
              return InkWell(
                onTap: () {
                  context.read<VideoPlayerCubit>().toggleControls();
                },
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: state.controller.value.aspectRatio,
                          child: VideoPlayer(state.controller),
                        ),
                        if (state.showControls) ...[
                          ControlsOverlay(
                            title: movieDetail.title,
                            state: state,
                            width: width,
                            height: height,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      ),
    );
  }
}
