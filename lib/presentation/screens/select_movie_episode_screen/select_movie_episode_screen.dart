import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/presentation/blocs/select_movie_episode/select_movie_episode_cubit.dart';
import 'package:vuiphim/presentation/screens/select_movie_episode_screen/widgets/episode_list_widget.dart';
import 'package:vuiphim/presentation/utils/shimmer.dart';

class SelectMovieEpisodeScreen extends StatelessWidget {
  final MovieDetailEntity movieDetail;

  const SelectMovieEpisodeScreen({super.key, required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocProvider<SelectMovieEpisodeCubit>(
      create: (context) =>
          SelectMovieEpisodeCubit()..initializeEpisodes(movieDetail.id),

      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: movieDetail.backdropUrl,
                    height: height * 0.425,
                    placeholder: (context, url) =>
                        Shimmer(height: height * 0.425, width: width),
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 1),
                    fadeOutDuration: const Duration(milliseconds: 1),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Phim: ${movieDetail.title}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        EpisodeListWidget(movieDetail: movieDetail),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 10,
                top: 10,
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(150),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
