import 'package:flutter/material.dart';
import 'package:taghyeer_assessment/features/products/model/product_model.dart';

class ProductHeader extends StatelessWidget {
  final ProductModel product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),

        Text(
          "${product.brand} • ${product.category}",
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              product.rating.toStringAsFixed(1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            Text("(${product.reviews.length} reviews)"),
          ],
        ),
      ],
    );
  }
}
