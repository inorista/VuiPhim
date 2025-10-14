import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/presentation/blocs/video_player/brightness/brightness_cubit.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cotrols/video_player_cubit.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/widgets/smooth_slider_indicator.dart';
import 'package:vuiphim/presentation/utils/vertical_track_slider.dart';

class ControlsOverlay extends StatelessWidget {
  final String title;
  final VideoPlayerState state;
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
            Positioned(
              left: 0,
              child: SafeArea(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sun_light_icon.svg',
                      width: 25,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<BrightnessCubit, BrightnessState>(
                      builder: (context, state) {
                        if (state is BrightnessError) {
                          return const SizedBox();
                        }
                        if (state is BrightnessLoaded) {
                          return VerticalTrackSlider(
                            value: state.brightness,
                            min: 0,
                            max: 1,
                            activeColor: Colors.white,
                            height: 120,
                            onChanged: (value) async {
                              try {
                                await context
                                    .read<BrightnessCubit>()
                                    .setBrightness(value);
                              } catch (e) {
                                log('Error setting brightness: ');
                              }
                            },
                            width: 15,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 20,
              right: 40,
              child: InkWell(
                onTap: () async {
                  context.pop();
                  await context.read<VideoPlayerCubit>().close();
                },
                child: const Center(
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

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
            Positioned(
              bottom: 30,
              child: SizedBox(
                height: 20,
                width: width * 0.9,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SmoothVideoProgressSlider()),
                    BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
                      buildWhen: (previous, current) {
                        if (current.status == VideoPlayerStatus.ready &&
                            previous.status == VideoPlayerStatus.ready) {
                          return current.position.inSeconds !=
                              previous.position.inSeconds;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state.status == VideoPlayerStatus.ready) {
                          return Text(
                            state.position.toFormattedString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
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
