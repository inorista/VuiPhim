import 'package:vuiphim/data/hive_database/hive_entities/move_entity/movie_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

class ContinueWatchingUIModel {
  final ServerDataEntity serverData;
  final MovieEntity movie;

  ContinueWatchingUIModel({required this.serverData, required this.movie});
}
