part of 'posts_bloc.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsEmpty extends PostsState {}

class PostsError extends PostsState {
  final String message;
  PostsError(this.message);
}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;
  final int total;
  final int skip;
  final bool isPaginating;
  final bool hasReachedMax;

  PostsLoaded({
    required this.posts,
    required this.total,
    required this.skip,
    this.isPaginating = false,
    this.hasReachedMax = false,
  });

  PostsLoaded copyWith({
    List<PostModel>? posts,
    int? total,
    int? skip,
    bool? isPaginating,
    bool? hasReachedMax,
  }) => PostsLoaded(
    posts: posts ?? this.posts,
    total: total ?? this.total,
    skip: skip ?? this.skip,
    isPaginating: isPaginating ?? this.isPaginating,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
  );
}
