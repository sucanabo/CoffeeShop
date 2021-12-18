part of services;

enum VerificationType { SUCCESS, ERROR }
class FireBaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static int _forceResendingToken;
  static String _verificationId = "";

  ///call this again with isResend = true to resent OTP
  static Future<void> sendOTP({
    @required String phoneNumber,
    // required Function() verificationCompleted,
    @required Function() verificationFailed,
    @required Function() codeSent,
    bool isResend = false,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeout,
      verificationCompleted: (PhoneAuthCredential credential) async {
        showToast(LocaleKeys.verify_complete.tr(),toastLength: Toast.LENGTH_LONG);
      },
      verificationFailed: (FirebaseAuthException e) {
        showToast(e.message ?? LocaleKeys.phone_invalid.tr(),toastLength: Toast.LENGTH_LONG);
        verificationFailed();
      },
      codeSent: (String verificationId, int resendToken) async {
        //mã xác thực đã được gửi tới điện thoại
        _forceResendingToken = resendToken;
        _verificationId = verificationId;
        print("sendOTP - codeSent");
        print("sendOTP - $resendToken");
        codeSent();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        codeSent();
      },
      forceResendingToken: isResend ? _forceResendingToken : null,
    );
  }

  static Future<void> verifyOTP({
    @required String otp,
    @required Function(VerificationType type) verification,
  }) async {
    print("FireBaseAuthService - verifyOTP Logged in");
    _signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      ),
      verification,
    );
  }

  static Future<void> _signInWithCredential(
    PhoneAuthCredential credential,
    Function(VerificationType type) verification,
  ) async {
    try {
      await _auth.signInWithCredential(credential).then((value) async {
        if (value.user != null) {
          print("FireBaseAuthService - _signInWithCredential Logged in");
          _forceResendingToken = null;
          verification(VerificationType.SUCCESS);
        } else {
          print(
              "FireBaseAuthService - _signInWithCredential FAIL - value.user null");
          verification(VerificationType.ERROR);
        }
      });
    } catch (e) {
      print("FireBaseAuthService - _signInWithCredential FAIL");
      verification(VerificationType.ERROR);
      print(e);
    }
  }
}