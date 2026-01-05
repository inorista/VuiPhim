import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:vuiphim/core/constants/api_constants.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/search/movie")
  Future<dynamic> getMovieByKeyword({
    @Query('query') required String query,
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/popular")
  Future<dynamic> getPopularMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/top_rated")
  Future<dynamic> getTopRatedMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/upcoming")
  Future<dynamic> getUpcomingMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/discover/movie")
  Future<dynamic> getMoviesByGenre({
    @Query('with_genres') required int genreId,
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/genre/movie/list")
  Future<dynamic> getMovieGenres({
    @Query('language') String? language = 'vi',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/{movie_id}")
  Future<dynamic> fetchMovieDetailFromId(
    @Path("movie_id") String movieId, {
    @Query('language') String? language = 'vi-VN',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/{movie_id}/credits")
  Future<dynamic> fetchMovieCreditsFromId(
    @Path("movie_id") String movieId, {
    @Query('language') String? language = 'vi-VN',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/now_playing")
  Future<dynamic> getNowPlayingMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });
}
