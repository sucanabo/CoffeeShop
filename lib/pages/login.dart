import 'package:coffee_shop/services/my_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: SizedBox(
              height: 20.0,
            ),
          ),
          title: Text(
            'Login',
            style: TextStyle(fontSize: 26.0),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
            Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Let\'s sign you in',
                        style: TextStyle(
                            color: colorPrimary,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        child: Text(
                          'Welcome back, you have been missed.',
                          style: TextStyle(fontSize: 18, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Column(
                    children: [
                      TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          prefixIcon: LineIcon.user(
                            size: 26.0,
                            color: colorPrimary_medium,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          hintText: 'Email & Phone number',
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: InputDecoration(
                          prefixIcon: LineIcon.lock(
                            size: 26.0,
                            color: colorPrimary_medium,
                          ),
                          suffixIcon: SizedBox(
                            width: 150.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot ?',
                                  style: TextStyle(
                                      color: colorPrimary_medium,
                                      fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: LineIcon.eye(),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign in',
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 5.0,
                              primary: colorPrimary,
                              shadowColor: colorPrimary,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0.0)),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 40.0,
                          ))
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Don\'t you have an account ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: TextButton.styleFrom(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.zero),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Register',
                                  style: TextStyle(color: colorPrimary_medium)),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: colorPrimary_medium,
                              )
                            ]),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LineIcon.googlePlusG(
                            color: Colors.red[500],
                            size: 30.0,
                          ),
                          Text(
                            'Login with Google',
                            style: TextStyle(color: colorBlack, fontSize: 16.0),
                          ),
                          LineIcon.arrowRight(
                            color: colorBlack,
                            size: 25.0,
                          )
                        ],
                      )),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LineIcon.facebookF(
                            color: Colors.blue[500],
                            size: 25.0,
                          ),
                          Text(
                            'Login with Facebook',
                            style: TextStyle(color: colorBlack, fontSize: 16.0),
                          ),
                          LineIcon.arrowRight(
                            color: colorBlack,
                            size: 25.0,
                          )
                        ],
                      ))
                ],
              ),
            ),
          ))
        ]));
  }
}
