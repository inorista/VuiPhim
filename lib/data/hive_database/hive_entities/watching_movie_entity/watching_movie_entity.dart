import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:vuiphim/data/hive_database/hive_database.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/server_data_entity/server_data_entity.dart';

part 'watching_movie_entity.g.dart';

@HiveType(typeId: HiveBoxIds.watchingMovieBoxId)
class WatchingMovieEntity extends Equatable {
  @HiveField(0)
  final List<ServerDataEntity> serverDataList;
  @HiveField(1)
  final MovieDetailEntity movieDetail;

  const WatchingMovieEntity({
    required this.serverDataList,
    required this.movieDetail,
  });

  WatchingMovieEntity copyWith({
    List<ServerDataEntity>? serverDataList,
    MovieDetailEntity? movieDetail,
  }) {
    return WatchingMovieEntity(
      serverDataList: serverDataList ?? this.serverDataList,
      movieDetail: movieDetail ?? this.movieDetail,
    );
  }

  @override
  List<Object?> get props => [serverDataList, movieDetail];
}
