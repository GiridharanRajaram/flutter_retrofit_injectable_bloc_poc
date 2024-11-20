import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/bloc/post_bloc_bloc.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/local_db/dao/post_dao.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/network/service.dart';

import 'injection_conatainer/injection.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<PostBloc>()
            // PostBloc(
            //     apiService: getIt<PostService>(), postDao: getIt<PostDao>()),
            ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
