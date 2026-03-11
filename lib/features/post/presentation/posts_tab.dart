import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    if (state is PostsLoading) return _buildCentered(const _LoadingIndicator());
    if (state is PostsError) {
      return _buildCentered(_ErrorView(state.message, context));
    }
    if (state is PostsEmpty) return _buildCentered(const _EmptyView());
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
        if (index == state.posts.length) return const _PaginationLoader();
        return PostCard(post: state.posts[index]);
      }, childCount: itemCount),
    );
  }
}

// ─── Loading ─────────────────────────────────────────────────────────────────

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) => const CircularProgressIndicator();
}

// ─── Error ───────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final BuildContext blocContext;

  const _ErrorView(this.message, this.blocContext);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => blocContext.read<PostsBloc>().add(PostsFetched()),
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}

// ─── Empty ───────────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.inbox_outlined, size: 48),
        SizedBox(height: 12),
        Text('No posts found.'),
      ],
    );
  }
}

// ─── Pagination loader ────────────────────────────────────────────────────────

class _PaginationLoader extends StatelessWidget {
  const _PaginationLoader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
