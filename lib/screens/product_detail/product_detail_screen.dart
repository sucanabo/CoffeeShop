part of screens;

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context).settings.arguments as Map;
    int productId = data['product_id'];
    String cartKey = data['cart_key'] ?? null;
    CartItemModel cartItem;
    if (cartKey != null) {
      cartItem = Provider.of<CartProvider>(context, listen: false)
          .findCartItemByKey(key: cartKey);
    }
    final product = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(productId);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: ProductDetailBody(
            product: product,
            cartEdit: cartKey != null,
            cartItem: cartKey != null ? cartItem : null,
          )),
    );
  }
}
