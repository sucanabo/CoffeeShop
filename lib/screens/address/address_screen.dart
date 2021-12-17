part of screens;

class AddressScreen extends StatefulWidget {
  static String routeName = '/address';
  final bool isChooseAddress;
  AddressScreen({this.isChooseAddress = false});
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _loading;

  void retriveData() async {
    String result =
        await Provider.of<AuthProvider>(context, listen: false).fetAddresses();
    if (result != null) {
      if (result == unauthorized) {
        logout(context);
      } else {
        showMess(context: context, text: result);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    retriveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.your_address.tr()),
        ),
        body: _loading
            ? ScreenBodyLoading()
            : AddressBody(
                isChooseAddress: widget.isChooseAddress,
              ));
  }
}
