part of screens;

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  //Get all product and category
  Future<void> retriveData({bool refresh = false}) async {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    if (!refresh)
      return;
    else {
      productProvider.setLoading(true);
    }

    if (productProvider.isLoading && refresh) {
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
        appBar: MyAppBar(
          appBar: AppBar(),
        ),
        floatingActionButton: FloatingCart(),
        body: Consumer<ProductProvider>(
            builder: (_, provider, __) => provider.isLoading
                ? ScreenBodyLoading()
                : ProductBody(onRefresh: () => retriveData(refresh: true))));
  }
}
