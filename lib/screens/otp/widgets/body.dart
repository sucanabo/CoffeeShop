part of screens;

enum OTPType { nomal, register }

class OTPBody extends StatefulWidget {
  final UserModel user;
  OTPBody({this.user});

  @override
  _OTPBodyState createState() => _OTPBodyState();
}

class _OTPBodyState extends State<OTPBody> {
  bool _loading = false;
  bool _buttonEnable = false;
  final TextEditingController _otpController = TextEditingController();
  int secondCounter = 0;
  int defaultSecond = 60;
  Timer timer;
  @override
  void initState() {
    super.initState();
    startTimmer();
    sendOTP();
  }

  @override
  void dispose() {
    timer.cancel();
    if (!mounted) _otpController.dispose();
    super.dispose();
  }

  void sendOTP() {
    setState(() {
      _loading = true;
    });
    String convertPhone =
        widget.user.phone.toString().trim().replaceRange(0, 1, '+84');
    FireBaseAuthService.sendOTP(
      phoneNumber: convertPhone,
      verificationFailed: () {},
      codeSent: () {},
    );
    setState(() {
      setState(() {
        _loading = false;
      });
    });
  }

  void verifyOTP(String otp) {
    FireBaseAuthService.verifyOTP(
        otp: otp,
        verification: (type) {
          if (type == VerificationType.SUCCESS) {
            print("VerifyRegisterController - verifyOTP - SUCCESS");
            Navigator.popAndPushNamed(context, NewPasswordScreen.routeName,
                arguments: widget.user);
          } else {
            print("VerifyRegisterController - verifyOTP - ERROR");
            //show error OTP invalid
          }
        });
  }

  void startTimmer() {
    secondCounter = defaultSecond;
    const onsec = Duration(seconds: 1);
    timer = Timer.periodic(onsec, (timer) {
      if (secondCounter == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          secondCounter--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        child: Container(
      padding: EdgeInsets.all(20.0),
      height: SizeConfig.screenHeigh,
      child: _loading
          ? ScreenBodyLoading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Column(
                    children: [
                      Text(
                        LocaleKeys.otp_verification.tr(),
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: getWidth(28.0),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(LocaleKeys.we_send_code_to
                          .tr(args: [widget.user.phone ?? ''])),
                      SizedBox(height: getHeight(20.0)),
                      Text(
                        LocaleKeys.send_otp_again.tr(
                          args: [secondCounter.toString()],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OTPForm(
                          otpController: _otpController,
                          onChanged: (value) {
                            setState(() {
                              _buttonEnable = value.length == 6;
                            });
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: PillButton(
                              child: Text(secondCounter != 0
                                  ? LocaleKeys.continue_text.tr()
                                  : LocaleKeys.resend_otp.tr()),
                              onPressed: () => secondCounter != 0
                                  ? _buttonEnable
                                      ? verifyOTP(_otpController.text)
                                      : null
                                  : startTimmer(),
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ]),
    ));
  }
}
