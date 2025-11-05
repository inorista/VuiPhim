import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';

class StickerDetail extends StatelessWidget {
  final MovieDetailEntity movieDetail;
  const StickerDetail({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        spacing: 14,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.65,
            height: height * 0.425,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: CachedNetworkImageProvider(movieDetail.posterUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movieDetail.title,
            style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
          Row(
            spacing: 7,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/vuiphim_logo_transparent.png',
                width: 20,
                height: 20,
              ),
              Text(
                'VuiPhim',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black.withAlpha(150),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
