import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cotrols/video_player_cubit.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/widgets/controls_overlay.dart';

class VideoPlayerView extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const VideoPlayerView({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            if (state.status == VideoPlayerStatus.loading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state.status == VideoPlayerStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage ?? 'An error occurred',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            if (state.status == VideoPlayerStatus.ready) {
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
                          aspectRatio: state.controller!.value.aspectRatio,
                          child: VideoPlayer(state.controller!),
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
