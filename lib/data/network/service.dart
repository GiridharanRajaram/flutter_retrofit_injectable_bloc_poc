import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/post_model.dart';

part 'service.g.dart';

@injectable
@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class PostService {
  @factoryMethod
  factory PostService(Dio dio) = _PostService;

  @GET("/posts")
  Future<List<Post>> getPosts();
}
