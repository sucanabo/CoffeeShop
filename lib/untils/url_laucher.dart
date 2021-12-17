part of untils;

class URLLaucher {
  static Future openLink({@required String url}) => _laucherUrl(url);
  static Future _laucherUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static openEmail(
      {@required String toEmail,
      @required String subject,
      @required String body}) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    await _laucherUrl(url);
  }

  static openPhoneCall({String phoneNumber}) async {
    final url = 'tel:$phoneNumber';
    await launch(url);
  }
}
