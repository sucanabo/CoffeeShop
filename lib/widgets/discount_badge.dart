import 'package:flutter/material.dart';

class DiscountBadge extends StatelessWidget {
  String discount;
  DiscountBadge({this.discount});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top:0,
        left: 1.0,
        child: SizedBox(
          width: 40.0,
          height: 30.0,
          child: TextButton(
            onPressed: (){},
            style: ButtonStyle(

                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    )
                )
            ),
            child: Text('-' + discount + '%', style: TextStyle(color: Colors.white),),
          ),
        )
    );
  }
}
