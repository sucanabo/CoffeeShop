part of screens;

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  void onDissmissed(int index, CartItemAction action) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final cartItem = cart.items.values.toList()[index];
    switch (action) {
      case CartItemAction.edit:
        Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: {
          'product_id': cartItem.product.id,
          'cart_key': cartItem.key
        });
        break;
      case CartItemAction.delete:
        cart.removeItem(cartItem.key);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) => ScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20.0),
              child: Text(
                'product_item_args',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  shadows: [
                    Shadow(color: AppColors.primaryColor, offset: Offset(0, -3))
                  ],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primaryColor,
                ),
              ).plural(cart.itemCount),
            ),
            if (cart.itemCount != 0)
              Hint(title: LocaleKeys.hint_swipe_to_edit.tr()),
            Expanded(
                child: cart.itemCount > 0
                    ? buildCartItem(context)
                    : buildGoShop()),
          ],
        ),
      ),
    );
  }

  Widget buildGoShop() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.no_item_in_cart.tr(),
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Align(
              child: Container(
                width: SizeConfig.screenWidth * 0.5,
                height: SizeConfig.screenHeigh * 0.3,
                child: SvgPicture.asset(
                  Res.ic_empty_cart,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          PillButton(
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<NavigationProvider>(context, listen: false)
                    .redirectScreen(ProductScreen());
              },
              color: AppColors.primaryMediumColor,
              child: Text(
                LocaleKeys.go_shop_now.tr(),
                style: TextStyle(fontSize: 18.0),
              ))
        ],
      ),
    );
  }

  Widget buildCartItem(context) {
    return Consumer<CartProvider>(
        builder: (context, cart, child) => ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10.0);
            },
            itemCount: cart.itemCount,
            padding: EdgeInsets.only(bottom: 80.0, left: 20.0, right: 20.0),
            itemBuilder: (context, index) => Slidable(
                  key: Key(
                      cart.items.values.toList()[index].product.id.toString()),
                  dismissal: SlidableDismissal(
                    child: SlidableDrawerDismissal(),
                    onDismissed: (type) {
                      final action = CartItemAction.delete;
                      onDissmissed(index, action);
                    },
                  ),
                  actionPane: SlidableDrawerActionPane(),
                  child: CartItem(item: cart.items.values.toList()[index]),
                  actionExtentRatio: 0.2,
                  secondaryActions: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: IconSlideAction(
                          onTap: () => onDissmissed(index, CartItemAction.edit),
                          caption: LocaleKeys.edit.tr(),
                          color: AppColors.primaryMediumColor,
                          icon: Icons.edit,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: IconSlideAction(
                            onTap: () =>
                                onDissmissed(index, CartItemAction.delete),
                            caption: LocaleKeys.delete.tr(),
                            color: AppColors.darkColor,
                            icon: Icons.delete),
                      ),
                    )
                  ],
                )));
  }
}
