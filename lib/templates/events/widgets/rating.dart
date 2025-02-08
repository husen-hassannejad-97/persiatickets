import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({super.key, required this.score});

  final double score;
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double _rating = 0.0;

  @override
  void initState() {
    _rating = widget.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        double starValue = index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = starValue;
            });
          },
          onPanUpdate: (details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset position = box.globalToLocal(details.globalPosition);
            double newRating = (position.dx / 50).clamp(0.5, 5.0);
            setState(() {
              _rating = (newRating * 2).round() / 2; // Round to nearest 0.5
            });
          },
          child: _buildStar(index + 1),
        );
      }),
    );
  }

  Widget _buildStar(int starIndex) {
    if (_rating >= starIndex) {
      // Full Star
      return Icon(Icons.star, color: Colors.amber, size: 20);
    } else if (_rating > starIndex - 1 && _rating < starIndex) {
      // Half Star
      return Stack(
        children: [
          Icon(Icons.star,
              color: Colors.transparent, size: 20), // Background empty star
          ClipRect(
            clipper: _HalfStarClipper(),
            child: Icon(Icons.star, color: Colors.amber, size: 20), // Half star
          ),
        ],
      );
    } else {
      // Empty Star
      return Icon(Icons.star_border, color: Colors.transparent, size: 20);
    }
  }
}

class _HalfStarClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
        0, 0, size.width / 2, size.height); // Clip half of the star
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
