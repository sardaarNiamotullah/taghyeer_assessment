import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taghyeer_assessment/core/widgets/empty_view.dart';
import 'package:taghyeer_assessment/core/widgets/error_view.dart';
import 'package:taghyeer_assessment/core/widgets/pagination_loader.dart';
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
    if (state is ProductsLoading) return _buildCentered(CircularProgressIndicator());
    if (state is ProductsError) {
      return _buildCentered(ErrorView(state.message, context));
    }
    if (state is ProductsEmpty) return _buildCentered(const EmptyView());
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
        if (index == state.products.length) return const PaginationLoader();
        return ProductCard(product: state.products[index]);
      }, childCount: itemCount),
    );
  }
}