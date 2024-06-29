import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating(
      {super.key,
      required this.rating,
      required this.filledColor,
      required this.emptyColor});
  final int rating;

  final Color filledColor;
  final Color emptyColor;
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          if (index < widget.rating) {
            return Icon(
              Icons.star,
              size: 20,
              color: widget.filledColor,
            );
          } else {
            return Icon(
              Icons.star_border,
              size: 15,
              color: widget.emptyColor,
            );
          }
        }));
  }
}
