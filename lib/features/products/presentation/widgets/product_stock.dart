import 'package:flutter/material.dart';
import 'package:taghyeer_assessment/features/products/model/product_model.dart';

class ProductStock extends StatelessWidget {
  final ProductModel product;

  const ProductStock({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final inStock = product.stock > 0;

    return Row(
      children: [
        Icon(
          inStock ? Icons.check_circle : Icons.cancel,
          color: inStock ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 6),
        Text(product.availabilityStatus),
      ],
    );
  }
}
