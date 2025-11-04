import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vuiphim/core/di/locator.dart';
import 'package:vuiphim/core/services/interfaces/iepisode_service.dart';
import 'package:vuiphim/core/utils/extensions.dart';
import 'package:vuiphim/data/hive_database/hive_daos/movie_detail_dao.dart';
import 'package:vuiphim/data/hive_database/hive_entities/episode_entity/episode_entity.dart';
import 'package:vuiphim/data/hive_database/hive_entities/movie_detail_entity/movie_detail_entity.dart';
import 'package:vuiphim/data/resources/kkphim_rest_client.dart';

part 'movie_source_state.dart';

class MovieSourceCubit extends Cubit<MovieSourceState> {
  MovieSourceCubit() : super(const MovieSourceState());

  final MovieDetailDao _movieDetailDao = locator<MovieDetailDao>();
  final IEpisodeService _episodeService = locator<IEpisodeService>();
  final KKPhimRestClient _kkphimRestClient = locator<KKPhimRestClient>();

  Future<void> getMovieSources({required int movieId}) async {
    try {
      emit(state.copyWith(status: MovieSourceStatus.loading));

      final movieDetail = await _movieDetailDao.getMovieDetailById(movieId);
      if (movieDetail == null) {
        throw Exception("Movie detail not found in local database.");
      }

      final existedEpisodes = await _episodeService.getEpisodesByMovieId(
        movieId,
      );

      if (existedEpisodes.isNotEmpty) {
        emit(
          state.copyWith(
            status: MovieSourceStatus.success,
            sources: existedEpisodes,
          ),
        );
      } else {
        final sources = await _fetchSourcesFromServer(movieDetail);
        emit(
          state.copyWith(status: MovieSourceStatus.success, sources: sources),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: MovieSourceStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<List<EpisodeEntity>> _fetchSourcesFromServer(
    MovieDetailEntity movieDetail,
  ) async {
    final searchResponse = await _kkphimRestClient.searchMovies(
      movieDetail.title,
    );

    final item = searchResponse.data?.items.firstOrDefault(
      (element) =>
          (int.tryParse(element.tmdb?.id ?? '') == movieDetail.id) ||
          element.time == movieDetail.title,
    );

    final slug = item?.slug;
    if (slug == null || slug.isEmpty) {
      throw Exception("Could not find a matching movie source.");
    }

    final sourceDto = await _kkphimRestClient.getMovieSources(slug);
    final sources = sourceDto.episodes
        .map((s) => s.toEntity(movieDetail.id))
        .toList();

    await _episodeService.saveEpisodes(sources);
    return sources;
  }
}
