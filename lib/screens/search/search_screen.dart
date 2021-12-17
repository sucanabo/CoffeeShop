part of screens;
class SearchScreen extends StatelessWidget {
  static String routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.search_product.tr()),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
