import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';

class BlurryBackground extends StatelessWidget {
  final MovieDetailEntity movieDetail;
  const BlurryBackground({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: movieDetail.backdropUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: width,
              height: height,
              color: Colors.black.withAlpha(35),
            ),
          ),
        ],
      ),
    );
  }
}
