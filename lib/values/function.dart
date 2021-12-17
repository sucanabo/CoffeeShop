part of values;

//decode image base64
MemoryImage base64StringToImage(String base64String) {
  return MemoryImage(base64Decode(base64String));
}

String imageToBase64String(String path) {
  if (path != null) {
    final bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }
  return null;
}

//Convert to hex color function
int hexColor(String color) {
  //add prefix
  String newColor = '0xff' + color;
  //remove #
  newColor = newColor.replaceAll('#', '');
  //convert it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}

//caculatePrice
double caculatePrice({discount, price}) {
  return price * ((100 - discount) / 100);
}

//Convert VND currency
String convertVND(double price) {
  return NumberFormat.currency(locale: "vi", symbol: 'đ').format(price);
}

//show SnackBar Message
void showMess({@required BuildContext context, @required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

//Capital String
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

//date formart
String formatDateToString(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String formatDateToStringWithTime(DateTime date) {
  return DateFormat('HH:mm - dd/MM/yyyy ').format(date);
}

DateTime formatStringToDate(String str) {
  return DateFormat('dd/MM/yyyy').parse(str);
}

//greeting
Widget greeting(String userName) {
  var hour = DateTime.now().hour;
  String session = '';
  if (hour < 12) {
    session = LocaleKeys.morning.tr();
  } else if (hour < 17)
    session = LocaleKeys.afternoon.tr();
  else
    session = LocaleKeys.evening.tr();
  return Row(children: <Widget>[
    SvgPicture.asset(
      hour < 17 ? Res.ic_sun : Res.ic_moon,
    ),
    SizedBox(width: 10.0),
    Text(
      '${LocaleKeys.gretting.tr()} $session, ${userName.split(' ').last}',
      style: TextStyle(
          color: AppColors.textColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w500),
    ),
  ]);
}

//copy clipboard
void coppyClipBoard(String text, context) {
  Clipboard.setData(ClipboardData(text: text)).then((value) => showMess(
      text: LocaleKeys.copied_into_clipboard.tr(args: [text]),
      context: context));
}

//show Toast
void showToast(
  String msg, {
  Toast toastLength = Toast.LENGTH_SHORT,
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      fontSize: 16.0);
}

//hide keyboard
void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

//set loading
void setLoading(context, {@required bool loading}) {
  final naviProvider = Provider.of<NavigationProvider>(context, listen: false);
  naviProvider.setLoading(loading);
}

double getDistance(double lat1, double lon1, double lat2, double lon2) {
  lon1 = lon1 * pi / 180;
  lon2 = lon2 * pi / 180;
  lat1 = lat1 * pi / 180;
  lat2 = lat2 * pi / 180;
  var dlon = lon2 - lon1;
  var dlat = lat2 - lat1;
  var a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  var c = 2 * asin(sqrt(a));
  var r = 6371;

  return (c * r);
}

String hiddenEmail(String str) {
  List<String> list = str.split('');
  var specialIndex = list.indexOf('@');
  list.forEachIndexed((index, item) {
    if (index > 2 && index < specialIndex) {
      list[index] = '*';
    }
  });
  return list.join();
}
