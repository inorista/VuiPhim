import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/presentation/screens/sticker_screen/widgets/blurry_background.dart';
import 'package:vuiphim/presentation/screens/sticker_screen/widgets/sticker_detail.dart';

class StickerScreen extends StatefulWidget {
  final MovieDetailEntity movieDetail;
  const StickerScreen({super.key, required this.movieDetail});

  @override
  State<StickerScreen> createState() => _StickerScreenState();
}

class _StickerScreenState extends State<StickerScreen> {
  late ScreenshotController screenshotStickerController;
  late ScreenshotController screenshotDetailController;
  @override
  void initState() {
    super.initState();
    screenshotStickerController = ScreenshotController();
    screenshotDetailController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Screenshot(
                controller: screenshotDetailController,
                child: BlurryBackground(movieDetail: widget.movieDetail),
              ),
            ),
            Screenshot(
              controller: screenshotStickerController,
              child: StickerDetail(movieDetail: widget.movieDetail),
            ),
          ],
        ),
      ),
    );
  }
}
