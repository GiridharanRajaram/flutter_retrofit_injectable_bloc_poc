part of 'post_bloc_bloc.dart';

sealed class PostBlocEvent extends Equatable {
  const PostBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchPost extends PostBlocEvent {}

class DeletePost extends PostBlocEvent {
  final int id;

  const DeletePost(this.id);
}

class UpdatePosts extends PostBlocEvent {
  final List<Post> posts;

 const UpdatePosts(this.posts);
}