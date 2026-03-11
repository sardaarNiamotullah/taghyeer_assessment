import 'package:flutter/material.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Products'),
            floating: true,
            pinned: false,
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('Product ${index + 1}'),
                subtitle: const Text('Demo product description'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              );
            }, childCount: 100),
          ),
        ],
      ),
    );
  }
}
