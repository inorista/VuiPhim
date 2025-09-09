import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
import 'package:vuiphim/core/dtos/cast_response_dto/cast_response_dto.dart';
import 'package:vuiphim/core/dtos/genre_response_dto/genre_response_dto.dart';
import 'package:vuiphim/core/dtos/movie_detail_dto/movie_detail_dto.dart';
import 'package:vuiphim/core/dtos/movie_response_dto/movie_response_dto.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/search/movie")
  Future<MovieResponseDto> getData({
    @Query('query') required String query,
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/popular")
  Future<MovieResponseDto> getPopularMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/top_rated")
  Future<MovieResponseDto> getTopRatedMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/upcoming")
  Future<MovieResponseDto> getUpcomingMovies({
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/discover/movie")
  Future<MovieResponseDto> getMoviesByGenre({
    @Query('with_genres') required int genreId,
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/genre/movie/list")
  Future<GenreResponseDto> getMovieGenres({
    @Query('language') String? language = 'vi',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/{movie_id}")
  Future<MovieDetailDto> fetchMovieDetailFromId(
    @Path("movie_id") String movieId, {
    @Query('language') String? language = 'vi-VN',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("/movie/{movie_id}/credits")
  Future<CastResponseDto> fetchMovieCreditsFromId(
    @Path("movie_id") String movieId, {
    @Query('language') String? language = 'vi-VN',
    @CancelRequest() CancelToken? cancelToken,
  });
}
