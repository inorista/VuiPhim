import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

class VideoPlayerScreen extends StatefulWidget {
  final ServerDataEntity serverData;
  const VideoPlayerScreen({super.key, required this.serverData});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  Future<bool> _onWillPop() async {
    // Reset về dọc ngay  back
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return true;
  }

  void toggleControls() {
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
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned.fill(child: VideoPlayer(_controller)),
                          Visibility(
                            visible: !_controller.value.isPlaying,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: !_controller.value.isPlaying ? 1.0 : 0.0,
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
                                      child: IconButton(
                                        iconSize: 80,
                                        color: Colors.white,
                                        icon: _controller.value.isPlaying
                                            ? const Icon(Icons.pause_circle)
                                            : const Icon(Icons.play_circle),
                                        onPressed: () {
                                          toggleControls();
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: SizedBox(
                                        height: 10,
                                        width: width * 0.9,
                                        child: VideoProgressIndicator(
                                          _controller,
                                          allowScrubbing: true,
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
                ),
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
