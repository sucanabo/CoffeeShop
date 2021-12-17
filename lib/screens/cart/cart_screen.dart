part of screens;
class CartScreen extends StatefulWidget {
  static String routeName = '/cart';
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        bottomSheet: cart.itemCount > 0 ? CartBottomSheet() : null,
        appBar: AppBar(
          title: Text(LocaleKeys.cart.tr()),
        ),
        body: AddressBody());
  }
}
