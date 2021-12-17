part of screens;

class MoreScreen extends StatelessWidget {
  static String routeName = '/more';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LanguageProvider>(builder: (context, provider, child) {
        return CustomScrollView(
          slivers: [
            Header(expandHeight: 250, roundedContainerHeight: 50),
            SliverToBoxAdapter(
              child: MoreBody(),
            )
          ],
        );
      }),
    );
  }
}
