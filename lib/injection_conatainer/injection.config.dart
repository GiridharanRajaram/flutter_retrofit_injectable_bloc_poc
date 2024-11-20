// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutter_retrofit_injectable_bloc_poc/bloc/post_bloc_bloc.dart'
    as _i6;
import 'package:flutter_retrofit_injectable_bloc_poc/data/local_db/database/post_database.dart'
    as _i3;
import 'package:flutter_retrofit_injectable_bloc_poc/data/network/service.dart'
    as _i5;
import 'package:flutter_retrofit_injectable_bloc_poc/injection_conatainer/injection.dart'
    as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.PostDataBase>(
      () => registerModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
    gh.factory<_i5.PostService>(() => _i5.PostService(gh<_i4.Dio>()));
    gh.factory<_i6.PostBloc>(() => _i6.PostBloc(
          apiService: gh<_i5.PostService>(),
          postDataBase: gh<_i3.PostDataBase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i7.RegisterModule {}
