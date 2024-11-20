part of 'post_bloc_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostBlocInitial extends PostState {}

class PostBlocLoading extends PostState {}

class PostBlocLoaded extends PostState {
  final List<Post> getResults;

  const PostBlocLoaded({required this.getResults});
  @override
  List<Object> get props => [getResults];
}

class PostBlocError extends PostState {
  final String error;

  const PostBlocError({required this.error});
  @override
  List<Object> get props => [error];
}

class PostBlocSuccess extends PostState {
  final String message;

  const PostBlocSuccess({required this.message});
}
