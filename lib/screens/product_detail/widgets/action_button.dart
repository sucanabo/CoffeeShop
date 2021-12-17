import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/screens/product_detail/widgets/rating_dialog.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/services.dart';

import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:coffee_shop/values/values.dart';
import 'package:easy_localization/easy_localization.dart';
class ActionButton extends StatefulWidget {
  final Icon icon;
  final bool isActive;
  final Color activeColor;
  final String type;
  final int productId;

  ActionButton(
      {@required this.icon,
      @required this.activeColor,
      @required this.isActive,
      @required this.type,
      @required this.productId});

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isActive;
  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
  }

  void setActive() {
    if (widget.type == 'favourite') {
      setState(() {
        _isActive = !_isActive;
      });
    } else if (widget.type == 'rating') {
      if (_isActive == false) {
        setState(() {
          _isActive = !_isActive;
        });
      }
    }
  }

  createRatingDialog(BuildContext context, int productId) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    RatingModel ratingModel =
        productProvider.getProductRating(widget.productId);
    return showDialog(
        context: context,
        builder: (context) {
          return new RatingDialog(
            productId: productId,
            dialogContext: context,
            pageContext: this.context,
            rating: ratingModel,
            onActive: () => setActive(),
          );
        });
  }

  void _handleProductFavourite(int productId) async {
    ApiResponse response = await favouriteOrUnfavourite(productId);
    if (response.error == null) {
      setActive();
      Provider.of<ProductProvider>(context, listen: false)
          .setProductFavourite(productId);
      _isActive
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(LocaleKeys.favourite_added.tr())))
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(LocaleKeys.favourite_deleted.tr())));
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 60.0, height: 60.0),
      child: ElevatedButton(
          onPressed: () {
            if (widget.type == 'favourite')
              _handleProductFavourite(widget.productId);
            else if (widget.type == 'rating')
              createRatingDialog(context, widget.productId);
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: _isActive ? widget.activeColor : Colors.grey[400]),
          child: widget.icon),
    );
  }
}
