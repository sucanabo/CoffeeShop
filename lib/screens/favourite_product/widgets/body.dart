part of screens;
class FavouriteBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> list =
        Provider.of<ProductProvider>(context, listen: false)
            .getFavouriteProducts;
    return Consumer<ProductProvider>(
        builder: (_, products, __) => list.length == 0
            ? _buildEmptyProduct()
            : ListView.builder(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                itemCount: list.length,
                itemBuilder: (context, index) => ProductWidget(
                  isLarge: true,
                  product: list[index],
                ),
              ));
  }

  Widget _buildEmptyProduct() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          LocaleKeys.dont_have_favourite_yet.tr(),
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
