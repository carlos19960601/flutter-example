import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:office_furniture_store_app/core/app_color.dart';

class StarRatingBar extends StatelessWidget {
  const StarRatingBar({
    super.key,
    required this.score,
    this.itemSize = 20,
  });

  final double score;
  final double itemSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemPadding: EdgeInsets.zero,
      itemSize: itemSize,
      itemCount: 5,
      initialRating: score,
      minRating: 1,
      direction: Axis.horizontal,
      glow: false,
      allowHalfRating: true,
      ignoreGestures: true,
      itemBuilder: (BuildContext context, int index) {
        return const Icon(
          Icons.star,
          size: 2.0,
          color: AppColor.lightOrange,
        );
      },
      onRatingUpdate: (double value) {},
    );
  }
}
