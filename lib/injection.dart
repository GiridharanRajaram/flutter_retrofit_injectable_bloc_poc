import 'package:dio/dio.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/service.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  PostService get postService => PostService(dio);
}
