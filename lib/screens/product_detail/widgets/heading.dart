part of screens;

class Heading extends StatelessWidget {
  final String title;
  const Heading({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 26.0, fontWeight: FontWeight.w500, height: 1.5),
        ));
  }
}
