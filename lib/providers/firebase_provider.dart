part of providers;

class FirebaseProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  dynamic _user;
  dynamic get user => _user;
  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future googleAuth(BuildContext context) async {
    try {
      final NavigationProvider naviProvider =
          Provider.of(context, listen: false);
      await googleSignIn.signOut();
      if (googleSignIn.currentUser != null) googleSignIn.disconnect();

      final googleUser = await googleSignIn.signIn();
      naviProvider.setLoading(true);

      if (googleUser == null) {
        naviProvider.setLoading(false);
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final authResult = await _auth.signInWithCredential(credential);

      if (authResult != null) {
        _user = googleUser;
        checkMailAndLogin(context, googleUser.email,
            prefKey: PrefKey.GOOGLE_SIGN_IN);
      }
      naviProvider.setLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }

  Future facebookLogin(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      setLoading(context, loading: true);
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);
      final authResult =
          await _auth.signInWithCredential(facebookAuthCredential);
      _user = authResult.user;
      checkMailAndLogin(context, authResult.user.email,
          prefKey: PrefKey.FACEBOOK_SIGN_IN);
      setLoading(context, loading: false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email;
        AuthCredential pendingCredential = e.credential;

        List<String> userSignInMethods =
            await _auth.fetchSignInMethodsForEmail(email);

        if (userSignInMethods.first == 'google.com') {
          final googleUser = await googleSignIn.signIn();
          final googleAuth = await googleUser.authentication;
          final googleCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          UserCredential userCredential =
              await _auth.signInWithCredential(googleCredential);
          userCredential.user.linkWithCredential(pendingCredential);
          _user = googleUser;
          checkMailAndLogin(context, email);
        }
      }
      setLoading(context, loading: false);
    }
  }

  Future googleLogOut() async {
    await googleSignIn.disconnect();
    _auth.signOut();
  }

  Future facebookLogOut() async {
    await FacebookAuth.instance.logOut();
    _auth.signOut();
  }

  Future checkMailAndLogin(BuildContext context, String email,
      {String prefKey}) async {
    final ApiResponse response = await loginEmail(email);
    if (response.error == null && response.data != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final UserModel user = response.data as UserModel;
      final AuthProvider provider =
          Provider.of<AuthProvider>(context, listen: false);
      print(user.displayName);
      provider.setUser(user);
      pref.setString(PrefKey.TOKEN, user.token ?? '');
      pref.setInt(PrefKey.ID, user.id ?? 0);
      //save login type
      if (prefKey != null) {
        pref.setBool(prefKey, true);
      } else {
        pref.setBool(PrefKey.FACEBOOK_SIGN_IN, true);
        pref.setBool(PrefKey.GOOGLE_SIGN_IN, true);
      }
      final User instance = FirebaseAuth.instance.currentUser;
      instance.delete();
      clearUser();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainBody()),
          (route) => false);
    } else {
      Navigator.of(context).pushNamed(SignUpScreen.routeName);
    }
  }
}
