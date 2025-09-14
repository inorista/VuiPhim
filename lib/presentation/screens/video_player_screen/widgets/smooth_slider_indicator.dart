import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cubit.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_state.dart';

class SmoothVideoProgressSlider extends StatefulWidget {
  const SmoothVideoProgressSlider({super.key});

  @override
  State<SmoothVideoProgressSlider> createState() =>
      _SmoothVideoProgressSliderState();
}

class _SmoothVideoProgressSliderState extends State<SmoothVideoProgressSlider> {
  double? _sliderValue;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      buildWhen: (previous, current) {
        if (current is VideoPlayerReady && previous is VideoPlayerReady) {
          return current.duration != previous.duration ||
              (!_isDragging && current.position != previous.position);
        }
        return true;
      },
      builder: (context, state) {
        if (state is VideoPlayerReady) {
          final maxValue = state.duration.inSeconds > 0
              ? state.duration.inSeconds.toDouble()
              : 1.0;

          final currentValue = _isDragging && _sliderValue != null
              ? _sliderValue!
              : state.position.inSeconds
                    .clamp(0, state.duration.inSeconds)
                    .toDouble();

          return Slider(
            activeColor: const Color(0xffff7b7b),
            min: 0,
            max: maxValue,
            value: currentValue,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });

              _throttledSeek(newValue);
            },
            onChangeStart: (value) {
              setState(() {
                _isDragging = true;
                _sliderValue = value;
              });
              context.read<VideoPlayerCubit>().onSliderChangeStart();
            },
            onChangeEnd: (value) {
              setState(() {
                _isDragging = false;
                _sliderValue = null;
              });

              final finalPosition = Duration(seconds: value.toInt());
              context.read<VideoPlayerCubit>().seekTo(finalPosition);
              context.read<VideoPlayerCubit>().onSliderChangeEnd();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  DateTime? _lastSeekTime;

  void _throttledSeek(double value) {
    final now = DateTime.now();
    if (_lastSeekTime == null ||
        now.difference(_lastSeekTime!).inMilliseconds > 100) {
      _lastSeekTime = now;
      final position = Duration(seconds: value.toInt());
      context.read<VideoPlayerCubit>().seekTo(position);
    }
  }
}
