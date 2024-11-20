import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/local_db/dao/post_dao.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/local_db/database/post_database.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/network/service.dart';
import 'package:injectable/injectable.dart';

import '../data/models/post_model.dart';

part 'post_bloc_event.dart';
part 'post_bloc_state.dart';

@injectable
class PostBloc extends Bloc<PostBlocEvent, PostState> {
  final PostService apiService;
  final PostDataBase postDataBase;

  late final StreamSubscription<List<Post>> _postSubscription;

  PostBloc({required this.apiService, required this.postDataBase})
      : super(PostBlocInitial()) {
    on<FetchPost>(_postBlocFetchEvent);
    on<DeletePost>(_postBlocDeleteEvent);
    _postSubscription = postDataBase.postDao.getAllPosts().listen((postList) {
      add(UpdatePosts(postList));
    });
    on<UpdatePosts>(_postBlocUpdateEvent);
  }

  FutureOr<void> _postBlocFetchEvent(
      FetchPost event, Emitter<PostState> emit) async {
    emit(PostBlocLoading());
    try {
      postDataBase.postDao.getAllPosts().listen((postList) {
        emit(PostBlocLoaded(getResults: postList));
      });
      // Fetch posts from API
      final posts = await apiService.getPosts();
      log(posts.toString());
      // Insert posts into the local database
      await postDataBase.postDao.insert(posts);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionError) {
        // No internet connection, fetch from local database
        final posts = await postDataBase.postDao.getAllPosts().first;
        emit(PostBlocLoaded(getResults: posts));
      } else {
        // Some other DioError, emit error state
        emit(PostBlocError(error: 'Failed to fetch posts: ${e.message}'));
      }
    } catch (e) {
      emit(PostBlocError(error: 'Failed to fetch posts: $e'));
    }
  }

  FutureOr<void> _postBlocDeleteEvent(
      DeletePost event, Emitter<PostState> emit) async {
    try {
      emit(PostBlocLoading());
      await postDataBase.postDao.delete(event.id);
      emit(const PostBlocSuccess(message: 'Post deleted successfully'));
    } catch (e) {
      emit(PostBlocError(error: 'Failed to delete post: $e'));
    }
  }

  FutureOr<void> _postBlocUpdateEvent(
      UpdatePosts event, Emitter<PostState> emit) {
    if (event.posts.isEmpty) {
      emit(const PostBlocError(error: 'No posts available.'));
    } else {
      emit(PostBlocLoaded(getResults: event.posts));
    }
  }

  @override
  Future<void> close() {
    _postSubscription.cancel();
    return super.close();
  }
}
