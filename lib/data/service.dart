import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'post_model.dart';

part 'service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class PostService {
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  @GET("/posts")
  Future<List<Post>> getPosts();
}
