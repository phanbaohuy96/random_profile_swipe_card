
import 'package:random_profile_swipe_card/data/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

/// https://pub.dev/packages/retrofit

@RestApi(baseUrl: "https://randomuser.me/api/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  // ----------- VIDEO -----------
  @GET("0.4/?randomapi")
  Future<ResultUser> getUser();
 
}
