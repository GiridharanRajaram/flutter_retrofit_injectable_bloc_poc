import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/bloc/post_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostBloc postBloc;

  @override
  void initState() {
    super.initState();
    postBloc = context.read<PostBloc>();
    postBloc.add(FetchPost());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostBlocError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is PostBlocSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is PostBlocLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostBlocLoaded) {
            return ListView.builder(
              itemCount: state.getResults.length,
              itemBuilder: (context, index) {
                final post = state.getResults[index];
                log(post.id.toString());
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      postBloc.add(DeletePost(post.id));
                    },
                  ),
                );
              },
            );
          } else if (state is PostBlocError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No data found.'));
        },
      ),
    );
  }
}
