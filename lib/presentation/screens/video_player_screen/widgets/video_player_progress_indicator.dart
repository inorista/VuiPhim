import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cotrols/video_player_cubit.dart'
    show VideoPlayerCubit, VideoPlayerState, VideoPlayerStatus;

class VideoPlayerProgressIndicator extends StatelessWidget {
  const VideoPlayerProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (context, state) {
        if (state.status == VideoPlayerStatus.ready) {
          return Slider(
            activeColor: const Color(0xffff7b7b),
            min: 0,
            max: state.duration.inSeconds > 0
                ? state.duration.inSeconds.toDouble()
                : 1.0,
            value: state.position.inSeconds
                .clamp(0, state.duration.inSeconds)
                .toDouble(),
            onChanged: (newValue) {
              context.read<VideoPlayerCubit>().onSliderChangeEnd(
                Duration(seconds: newValue.toInt()),
              );
            },
            onChangeStart: (value) {
              context.read<VideoPlayerCubit>().onSliderChangeStart();
            },
            onChangeEnd: (value) {
              final finalPosition = Duration(seconds: value.toInt());
              context.read<VideoPlayerCubit>().onSliderChangeEnd(finalPosition);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
