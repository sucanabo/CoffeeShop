import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/rating.dart';
import 'package:coffee_shop/providers/product_provider.dart';
import 'package:coffee_shop/services/product_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/widgets/rating.dart';
import 'package:coffee_shop/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatingDialog extends StatefulWidget {
  final RatingModel rating;
  final int productId;
  final BuildContext dialogContext;
  final BuildContext pageContext;
  final Function onActive;
  const RatingDialog(
      {this.rating,
      this.dialogContext,
      this.productId,
      this.pageContext,
      this.onActive});

  @override
  _RatinDialogState createState() => _RatinDialogState();
}

class _RatinDialogState extends State<RatingDialog> {
  RatingModel _ratingModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtReview = TextEditingController();

  int _starTemp;
  bool _starErr;

  void setStarError() {
    setState(() {
      _starErr = !_starErr;
    });
  }

  @override
  void initState() {
    _ratingModel = widget.rating;
    _txtReview.text = _ratingModel.review ?? null;
    _starErr = false;
    super.initState();
  }

  //post reting
  void _postRating(star, review) async {
    print('star $star, $review');
    if (star == 0) {
      setStarError();
    } else if (star != widget.rating.star || star != 0) {
      print('other rating');
      ApiResponse response = await postRating(
          productId: widget.productId, star: star, review: review);
      if (response.error == null) {
        this.widget.onActive();
        RatingModel newRating = RatingModel(star: star, review: review);
        Provider.of<ProductProvider>(context, listen: false)
            .setProductRating(productId: widget.productId, rating: newRating);
        Navigator.pop(widget.dialogContext);
        showMess(
            context: widget.pageContext, text: 'Thanks for your rating <3');
      } else {
        showMess(context: widget.pageContext, text: '${response.error}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 280.0,
        height: 350.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text('Rate:'),
                        ),
                        Rating(
                          currentRating: _ratingModel.star,
                          onRatingSelected: (rating) {
                            _starTemp = rating;
                            if (_starErr) setStarError();
                          },
                        )
                      ],
                    ),
                    _starErr
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Please choose number of star',
                              style: TextStyle(color: Colors.red[300]),
                            ),
                          )
                        : Text('')
                  ],
                )),
            Expanded(
                flex: 7,
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (val) =>
                          val.length > 255 ? 'Review max length is 255.' : null,
                      textInputAction: TextInputAction.done,
                      controller: _txtReview,
                      maxLines: 8,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                          ),
                          hintText: 'Product review (not required)...'),
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: RoundedButton(
                        onPressed: () {
                          Navigator.pop(widget.dialogContext);
                        },
                        color: AppColors.primaryLightColor,
                        title: 'Cancel',
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: RoundedButton(
                        onPressed: () {
                          _postRating(
                              _starTemp != null ? _starTemp : _ratingModel.star,
                              _txtReview.text);
                        },
                        color: AppColors.primaryMediumColor,
                        title: 'Rate',
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
