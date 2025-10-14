import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';
import 'package:vuiphim/presentation/blocs/video_player/brightness/brightness_cubit.dart';
import 'package:vuiphim/presentation/blocs/video_player/video_player_cotrols/video_player_cubit.dart';
import 'package:vuiphim/presentation/screens/video_player_screen/widgets/video_player_view.dart';

class VideoPlayerScreen extends StatelessWidget {
  final ServerDataEntity serverData;
  final MovieDetailEntity movieDetail;

  const VideoPlayerScreen({
    super.key,
    required this.serverData,
    required this.movieDetail,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              VideoPlayerCubit()..initializePlayer(serverData.linkM3U8 ?? ''),
        ),
        BlocProvider(create: (context) => BrightnessCubit()..getBrightness()),
      ],
      child: VideoPlayerView(movieDetail: movieDetail),
    );
  }
}
