import 'package:flutter/material.dart';

class ProductImageGallery extends StatelessWidget {
  final List<String> images;

  const ProductImageGallery({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                const Center(child: Icon(Icons.broken_image, size: 100)),
          );
        },
      ),
    );
  }
}
