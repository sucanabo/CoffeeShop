part of screens;
class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeigh * 0.08,
      decoration: BoxDecoration(
          color: AppColors.darkColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<CartProvider>(
              builder: (context, cart, child) => Text(
                    '${LocaleKeys.subtotal.tr()} ${convertVND(cart.totalAmount)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            onPressed: () => Navigator.pushNamed(context, CheckoutScreen.routeName),
            child: Text(
              LocaleKeys.checkout.tr(),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
