import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class PositionedVoucher extends StatelessWidget {
  final RewardModel reward;
  PositionedVoucher({this.reward});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: SizeConfig.screenWidth / 2 - (SizeConfig.screenWidth * 0.85 / 2),
      bottom: -SizeConfig.screenHeigh * (0.13 / 2),
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        height: SizeConfig.screenHeigh * 0.13,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(Res.voucher_background))),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        image: base64StringToImage(reward.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reward.brandName,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.15),
                        ),
                        Text(
                          reward.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${LocaleKeys.expired_date.tr()} ${reward.expiryDate != null ? formatDateToString(reward.expiryDate) : ''}',
                          style: TextStyle(
                              fontSize: 15.0, color: AppColors.textColor),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
