import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;
  final int currentRating;

  Rating({this.maximumRating = 5, this.currentRating, this.onRatingSelected});
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _currentRating;
  @override
  void initState() {
    super.initState();
    _currentRating = widget.currentRating;
  }

  Widget _buildRatingStar(index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                color: Colors.grey[400].withOpacity(0.5),
                offset: Offset(2, 2))
          ]),
      child: index < _currentRating
          ? Icon(
              Icons.star_rounded,
              size: SizeConfig.screenWidth * 0.06,
              color: Colors.orange[300],
            )
          : Icon(
              Icons.star_border_rounded,
              size: SizeConfig.screenWidth * 0.06,
              color: Colors.grey,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return new GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });
          widget.onRatingSelected(_currentRating);
        },
      );
    });
    return Row(children: stars);
  }
}
