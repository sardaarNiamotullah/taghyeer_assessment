import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/core/widgets/empty_view.dart';
import 'package:taghyeer_assessment/core/widgets/error_view.dart';
import 'package:taghyeer_assessment/core/widgets/pagination_loader.dart';
import 'package:taghyeer_assessment/features/post/bloc/posts_bloc.dart';
import 'package:taghyeer_assessment/features/post/presentation/widgets/post_card.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        return NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 200) {
              context.read<PostsBloc>().add(PostsNextPageFetched());
            }
            return false;
          },
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Posts'),
                  floating: true,
                  pinned: false,
                ),
                _buildBody(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, PostsState state) {
    if (state is PostsLoading) return _buildCentered(const CircularProgressIndicator());
    if (state is PostsError) {
      return _buildCentered(ErrorView(state.message, context));
    }
    if (state is PostsEmpty) return _buildCentered(const EmptyView());
    if (state is PostsLoaded) return _buildList(state);
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  Widget _buildCentered(Widget child) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: child),
    );
  }

  SliverList _buildList(PostsLoaded state) {
    final itemCount = state.posts.length + (state.isPaginating ? 1 : 0);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == state.posts.length) return const PaginationLoader();
        return PostCard(post: state.posts[index]);
      }, childCount: itemCount),
    );
  }
}
