import 'package:flutter/material.dart';

class RatingSelectable extends StatefulWidget {
  RatingSelectable({required this.rate});

  final Function(double rate) rate;

  @override
  _RatingSelectableState createState() => _RatingSelectableState();
}

class _RatingSelectableState extends State<RatingSelectable> {
  double _rating = 0.0; // Initial rating

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTapDown: (details) {
            setState(() {
              // Determine if the user tapped the left or right half of the star
              final localPosition = details.localPosition.dx;
              final starWidth = 40.0; // Width of each star
              if (localPosition < starWidth / 2) {
                _rating = index + 0.5; // Half-star
              } else {
                _rating = index + 1.0; // Full star
              }
              widget.rate(_rating);
            });
          },
          child: Icon(
            _rating >= index + 1
                ? Icons.star // Full star
                : _rating >= index + 0.5
                    ? Icons.star_half // Half star
                    : Icons.star_border, // Empty star
            color: Colors.amber,
            size: 40,
          ),
        );
      }),
    );
  }
}
