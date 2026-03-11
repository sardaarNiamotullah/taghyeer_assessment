import 'package:flutter/material.dart';

class ProductSectionTitle extends StatelessWidget {
  final String title;

  const ProductSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Reviews",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
