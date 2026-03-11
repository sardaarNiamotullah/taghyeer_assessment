import 'package:flutter/material.dart';
import 'package:taghyeer_assessment/features/products/model/review.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_review_card.dart';
import 'package:taghyeer_assessment/features/products/presentation/widgets/product_section_title.dart';

class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Text("No reviews yet");
    }

    final visibleReviews = reviews.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProductSectionTitle(title: "Reviews"),

        const SizedBox(height: 10),

        ListView.builder(
          itemCount: visibleReviews.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ReviewCard(review: visibleReviews[index]);
          },
        ),
      ],
    );
  }
}