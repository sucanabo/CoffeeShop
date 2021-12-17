part of screens;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List _productSearch = [];

  void changeFilter(String searchString) {
    searchString =
        TiengViet.parse(searchString.toLowerCase().replaceAll(' ', '').trim());
    List result = [];
    final List allProduct =
        Provider.of<ProductProvider>(context, listen: false).productList;
    if (searchString.isNotEmpty) {
      for (var item in allProduct) {
        String title = TiengViet.parse(
            item.title.toString().toLowerCase().replaceAll(' ', '').trim());
        if (title.contains(searchString)) {
          result.add(item);
        }
      }
    } else {
      result = allProduct;
    }
    setState(() {
      _productSearch = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _productSearch =
        Provider.of<ProductProvider>(context, listen: false).productList;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        resizeToAvoidBottomInset: false,
        child: Column(children: [
          SearchBar(
            onChange: (value) {
              changeFilter(value);
            },
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _productSearch.length,
            itemBuilder: (context, index) =>
                ProductWidget(isLarge: true, product: _productSearch[index]),
          ))
        ]));
  }
}
