import 'package:flutter/material.dart';

class ProductTags extends StatelessWidget {
  final List<String> tags;

  const ProductTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox();

    return Wrap(
      spacing: 8,
      children: tags.map((tag) => Chip(label: Text(tag))).toList(),
    );
  }
}
