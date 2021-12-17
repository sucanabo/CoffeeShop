part of screens;
class SeeProductScreen extends StatelessWidget {
  const SeeProductScreen({this.data});
  final List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      appBar: AppBar(
        title: Text(LocaleKeys.update_profile.tr()),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
              data.length,
              (index) => ProductWidget(
                    product: data[index],
                    isLarge: true,
                  )),
        ),
      ),
    );
  }
}
