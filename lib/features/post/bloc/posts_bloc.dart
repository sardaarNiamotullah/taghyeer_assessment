import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/features/post/model/post_model.dart';
import 'package:taghyeer_assessment/features/post/repo/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepo _repo;

  PostsBloc(this._repo) : super(PostsInitial()) {
    on<PostsFetched>(_onFetched);
    on<PostsNextPageFetched>(_onNextPage);
  }

  Future<void> _onFetched(
    PostsFetched event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoading());
    try {
      final result = await _repo.fetchPosts(skip: 0);
      if (result.posts.isEmpty) {
        emit(PostsEmpty());
      } else {
        emit(PostsLoaded(
          posts: result.posts,
          total: result.total,
          skip: PostsRepo.limit,
        ));
      }
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onNextPage(
    PostsNextPageFetched event,
    Emitter<PostsState> emit,
  ) async {
    final current = state;
    if (current is! PostsLoaded) return;
    if (current.hasReachedMax || current.isPaginating) return;

    emit(current.copyWith(isPaginating: true));
    try {
      final result = await _repo.fetchPosts(skip: current.skip);
      final updated = [...current.posts, ...result.posts];
      emit(current.copyWith(
        posts: updated,
        skip: current.skip + PostsRepo.limit,
        isPaginating: false,
        hasReachedMax: updated.length >= result.total,
      ));
    } catch (e) {
      emit(current.copyWith(isPaginating: false));
    }
  }
}