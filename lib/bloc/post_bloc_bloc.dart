import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/service.dart';

import '../data/post_model.dart';

part 'post_bloc_event.dart';
part 'post_bloc_state.dart';

class PostBloc extends Bloc<PostBlocEvent, PostState> {
  final PostService apiService;
  PostBloc(this.apiService) : super(PostBlocInitial()) {
    on<FetchPost>(_postBlocFetchEvent);
  }

  FutureOr<void> _postBlocFetchEvent(
      FetchPost event, Emitter<PostState> emit) async {
    emit(PostBlocLoading());
    try {
      final posts = await apiService.getPosts();
      emit(PostBlocLoaded(getResults: posts));
    } catch (e) {
      emit(const PostBlocError(error: "Failed to fetch posts"));
    }
  }
}
