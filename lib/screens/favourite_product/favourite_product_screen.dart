part of screens;
class FavouriteProductScreen extends StatefulWidget {
  static String routeName = '/favourite_product';
  @override
  _FavouriteProductScreenState createState() => _FavouriteProductScreenState();
}

class _FavouriteProductScreenState extends State<FavouriteProductScreen> {
//Get all product and category
  Future<void> retriveData({bool refresh = false}) async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    if (productProvider.isLoading == true && refresh) {
      ApiResponse productResponse = await getProducts();
      ApiResponse categoryResponse = await getCategories();

      if (productResponse.error == null && categoryResponse.error == null) {
        productProvider.setProductList(productResponse.data);
        categoryProvider.setCategoryList(categoryResponse.data);
      } else if (categoryResponse.error == unauthorized ||
          productResponse.error == unauthorized) {
        logout(context);
      }
      productProvider.setLoading(false);
    }
  }


  @override
  void initState() {
    retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.favourite.tr()),
        centerTitle: true,
      ),
      body: Consumer<ProductProvider>(
        builder: (_, products, __) => ScreenBody(
          child: products.isLoading ? ScreenBodyLoading() : FavouriteBody(),
        ),
      ),
    );
  }
}
