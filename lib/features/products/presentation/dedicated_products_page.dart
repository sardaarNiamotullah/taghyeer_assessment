import 'package:flutter/material.dart';
import 'package:taghyeer_assessment/features/products/model/product_model.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_description.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_header.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_image_gallery.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_price.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_review_section.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_stock.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_tags.dart';

class DedicatedProductsPage extends StatelessWidget {
  final ProductModel product;

  const DedicatedProductsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageGallery(images: product.images),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  ProductHeader(product: product),
                  const SizedBox(height: 16),

                  ProductPrice(product: product),
                  const SizedBox(height: 20),

                  ProductStock(product: product),
                  const SizedBox(height: 20),

                  ProductDescription(description: product.description),
                  const SizedBox(height: 20),

                  ProductTags(tags: product.tags),
                  const SizedBox(height: 24),

                  ReviewsSection(reviews: product.reviews),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}