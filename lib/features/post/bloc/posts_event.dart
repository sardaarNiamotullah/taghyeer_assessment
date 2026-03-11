part of 'posts_bloc.dart';

abstract class PostsEvent {}

class PostsFetched extends PostsEvent {}

class PostsNextPageFetched extends PostsEvent {}
