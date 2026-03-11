import 'package:flutter/material.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_section_title.dart';

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProductSectionTitle(title: "Description"),

        const SizedBox(height: 6),

        Text(description, style: const TextStyle(height: 1.5)),
      ],
    );
  }
}
