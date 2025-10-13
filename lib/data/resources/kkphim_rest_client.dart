import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
import 'package:vuiphim/data/dtos/kkmovie_response_dto/kkmovie_response_dto.dart';
import 'package:vuiphim/data/dtos/kkmovie_sources_dto/kkmovie_sources_dto.dart';
part 'kkphim_rest_client.g.dart';

@RestApi(baseUrl: ApiConstants.kkphimBaseUrl)
abstract class KKPhimRestClient {
  factory KKPhimRestClient(Dio dio, {String baseUrl}) = _KKPhimRestClient;

  @GET("/v1/api/tim-kiem?keyword={keyword}&limit=64")
  Future<KkMovieResponseDto> searchMovies(
    @Path("keyword") String keyword, {
    @Query('language') String? language = 'vi-VN',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("phim/{slug}")
  Future<KkMovieSourceDto> getMovieSources(@Path("slug") String slug);
}
