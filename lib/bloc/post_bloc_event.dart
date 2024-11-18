part of 'post_bloc_bloc.dart';

sealed class PostBlocEvent extends Equatable {
  const PostBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchPost extends PostBlocEvent {}
