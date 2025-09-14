import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/core/native/brightness_native.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

class VideoPlayerScreen extends StatefulWidget {
  final ServerDataEntity serverData;
  final MovieDetailEntity movieDetail;
  const VideoPlayerScreen({
    super.key,
    required this.serverData,
    required this.movieDetail,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  double? _brightness;
  bool _showControls = false;

  Stream<double> get _positionStream =>
      Stream.periodic(const Duration(milliseconds: 100), (int _) {
        if (_controller.value.isInitialized) {
          return _controller.value.position.inSeconds.toDouble();
        }
        return 0.0;
      });

  Future<bool> _onWillPop() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return true;
  }

  void toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final brightness = await BrightnessNative.getBrightness();
      setState(() {
        _brightness = brightness;
      });
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse("${widget.serverData.linkM3U8}"),
          )
          ..initialize().then((_) {
            _controller.play();
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          await _onWillPop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _controller.value.isInitialized
            ? InkWell(
                onTap: () {
                  toggleControls();
                },
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        Visibility(
                          visible: _showControls,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _showControls ? 1.0 : 0.0,
                            child: Container(
                              width: width,
                              height: height,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(40),
                                      onTap: () {
                                        togglePlayPause();
                                      },
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Center(
                                          child: _controller.value.isPlaying
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
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      width: width * 0.9,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/images/vuiphim_logo_transparent.png',
                                              width: 55,
                                            ),
                                            const SizedBox(width: 10),
                                            SizedBox(
                                              width: 160,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      widget.movieDetail.title,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 7),
                                                  Text(
                                                    "${_controller.value.position.inHours.toString().padLeft(2, '0')}:${_controller.value.position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_controller.value.position.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${_controller.value.duration.inHours.toString().padLeft(2, '0')}:${_controller.value.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_controller.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Slider(
                                              activeColor: const Color(
                                                0xffff7b7b,
                                              ),

                                              min: 0,
                                              max: _controller
                                                  .value
                                                  .duration
                                                  .inSeconds
                                                  .toDouble(),
                                              value: _controller
                                                  .value
                                                  .position
                                                  .inSeconds
                                                  .toDouble(),
                                              onChanged: (value) {
                                                _controller.seekTo(
                                                  Duration(
                                                    seconds: value.toInt(),
                                                  ),
                                                );
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          StreamBuilder(
                                            stream: _positionStream,
                                            builder: (context, asyncSnapshot) {
                                              if (asyncSnapshot
                                                          .connectionState ==
                                                      ConnectionState.active &&
                                                  asyncSnapshot.hasData) {
                                                final positionInSeconds =
                                                    asyncSnapshot.data!;
                                                return Text(
                                                  "${Duration(seconds: positionInSeconds.toInt()).inHours.toString().padLeft(2, '0')}:${Duration(seconds: positionInSeconds.toInt()).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: positionInSeconds.toInt()).inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                      255,
                                                      255,
                                                      255,
                                                      1,
                                                    ),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                );
                                              }
                                              return Text(
                                                "${Duration(seconds: _controller.value.position.inSeconds).inHours.toString().padLeft(2, '0')}:${Duration(seconds: _controller.value.position.inSeconds).inMinutes.remainder(60).toString().padLeft(2, '0')}:${Duration(seconds: _controller.value.position.inSeconds).inSeconds.remainder(60).toString().padLeft(2, '0')}",
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                    255,
                                                    255,
                                                    255,
                                                    1,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
