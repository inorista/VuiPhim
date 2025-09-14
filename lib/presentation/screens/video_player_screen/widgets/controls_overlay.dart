import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cubit.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_state.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/video_player_screen.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/widgets/video_player_progress_indicator.dart';

class ControlsOverlay extends StatelessWidget {
  final String title;
  final VideoPlayerReady state;
  final double width;
  final double height;

  const ControlsOverlay({
    super.key,
    required this.title,
    required this.state,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: state.showControls ? 1.0 : 0.0,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Close button
            Positioned(
              top: 20,
              right: 40,
              child: InkWell(
                onTap: () => context.pop(),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Play/Pause button
            Align(
              alignment: Alignment.center,
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  context.read<VideoPlayerCubit>().togglePlayPause();
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: state.isPlaying
                        ? const Icon(
                            CupertinoIcons.pause,
                            size: 65,
                            color: Colors.white,
                          )
                        : const Icon(
                            CupertinoIcons.play_fill,
                            size: 65,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),

            // Movie info
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/vuiphim_logo_transparent.png',
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "${state.duration.inHours.toString().padLeft(state.duration.inHours < 10 ? 1 : 2, '0')}h ${state.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}m",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Progress slider and time
            Positioned(
              bottom: 30,
              child: SizedBox(
                height: 20,
                width: width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: VideoPlayerProgressIndicator()),
                    Text(
                      state.position.toFormattedString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
