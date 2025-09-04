import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:vuiphim/core/constants/api_constants.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/search/movie")
  Future<ResponseType> getData({
    @Query('query') required String query,
    @Query('language') String? language = 'vi-VN',
    @Query('page') int page = 1,
  });
}
