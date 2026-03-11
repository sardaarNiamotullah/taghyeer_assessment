import 'package:flutter/material.dart';
import 'package:taghyeer_assessment/features/products/model/product_model.dart';

class ProductPrice extends StatelessWidget {
  final ProductModel product;

  const ProductPrice({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          "\$${product.price.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        if (product.discountPercentage > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "-${product.discountPercentage.toStringAsFixed(0)}%",
              style: const TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }
}