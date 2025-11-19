import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vuiphim/core/constants/api_constants.dart';
part 'kkphim_rest_client.g.dart';

@RestApi(baseUrl: ApiConstants.kkphimBaseUrl)
abstract class KKPhimRestClient {
  factory KKPhimRestClient(Dio dio, {String baseUrl}) = _KKPhimRestClient;

  @GET("/v1/api/tim-kiem?keyword={keyword}&limit=64")
  Future<dynamic> searchMovies(
    @Path("keyword") String keyword, {
    @Query('language') String? language = 'vi-VN',
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET("phim/{slug}")
  Future<dynamic> getMovieSources(@Path("slug") String slug);
}
