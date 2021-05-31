import 'package:coffee_shop/services/my_color.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            'Register',
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
                          'Great to see you here!',
                          style: TextStyle(
                              color: colorPrimary,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 300.0,
                          child: Text(
                            'Let’s set up your account in just a couple of steps.',
                            style: TextStyle(fontSize: 18, height: 1.5),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          hintText: 'First name',
                                        ),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        hintText: 'Last name',
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ))
                              ],
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                hintText: 'Email',
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                hintText: 'Phone number',
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              key: Key('r_password'),
                              decoration: InputDecoration(
                                suffixIcon: SizedBox(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              key: Key('r_confirm_password'),
                              decoration: InputDecoration(
                                suffixIcon: SizedBox(
                                  width: 150.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                hintText: 'Confirm Password',
                              ),
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign up',
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
                      ],
                    ),
                  ],
                )),
          ))
        ]));
  }
}
