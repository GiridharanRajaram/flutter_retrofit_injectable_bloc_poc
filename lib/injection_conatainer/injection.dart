import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/local_db/database/post_database.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/injection_conatainer/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    log("Registering Dio");
    return Dio();
  }

  @preResolve
  Future<PostDataBase> get database async {
    log("Registering Database");
    return $FloorPostDataBase.databaseBuilder('post_database.db').build();
  }
}
