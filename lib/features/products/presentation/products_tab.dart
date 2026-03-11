import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/features/products/bloc/products_bloc.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_card.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 200) {
              context.read<ProductsBloc>().add(ProductsNextPageFetched());
            }
            return false;
          },
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Products'),
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

  Widget _buildBody(BuildContext context, ProductsState state) {
    if (state is ProductsLoading) return _buildCentered(_LoadingIndicator());
    if (state is ProductsError) {
      return _buildCentered(_ErrorView(state.message, context));
    }
    if (state is ProductsEmpty) return _buildCentered(const _EmptyView());
    if (state is ProductsLoaded) return _buildList(state);
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  Widget _buildCentered(Widget child) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: child),
    );
  }

  SliverList _buildList(ProductsLoaded state) {
    final itemCount = state.products.length + (state.isPaginating ? 1 : 0);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == state.products.length) return const _PaginationLoader();
        return ProductCard(product: state.products[index]);
      }, childCount: itemCount),
    );
  }
}

// ─── Loading ────────────────────────────────────────────────────────────────

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const CircularProgressIndicator();
}

// ─── Error ──────────────────────────────────────────────────────────────────

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
          onPressed: () =>
              blocContext.read<ProductsBloc>().add(ProductsFetched()),
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}

// ─── Empty ──────────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.inbox_outlined, size: 48),
        SizedBox(height: 12),
        Text('No products found.'),
      ],
    );
  }
}

// ─── Pagination loader ───────────────────────────────────────────────────────

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