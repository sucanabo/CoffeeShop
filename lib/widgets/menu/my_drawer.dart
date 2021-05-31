import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffee_shop/services/my_color.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List  menu_item = [
    //   {'title':'Home', 'img': 'home.svg'},
    //   {'title':'Home', 'img': 'account.svg'},
    //   {'title':'Home', 'img': 'transaction_history.svg'},
    //   {'title':'Home', 'img': 'your_favourite.svg'},
    //   {'title':'Home', 'img': 'setting.svg'},
    //   {'title':'Home', 'img': 'contact_us.svg'},
    // ];

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50.0)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/theme.jpg'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.jpg'),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center + Alignment(0.1, -0.2),
                        child: Text('Felix Dinh',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                      Align(
                        alignment: Alignment.center + Alignment(0.1, 0.3),
                        child: Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('New',
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.eco_outlined, color: Colors.white),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/images/icon/home.svg',
                      color: colorBlack),
                  title: Text('Home'),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/images/icon/account.svg',
                      color: colorBlack),
                  title: Text('My account'),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                      'assets/images/icon/transaction_history.svg',
                      color: colorBlack),
                  title: Text('Transaction History'),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                      'assets/images/icon/your_favourite.svg',
                      color: colorBlack),
                  title: Text('Your favourite'),
                ),
                SizedBox(height: 10.0),
                Divider(height: 1, color: Colors.grey[400]),
                SizedBox(height: 10.0),
                ListTile(
                  leading: SvgPicture.asset('assets/images/icon/setting.svg',
                      color: colorBlack),
                  title: Text('Setting'),
                ),
                ListTile(
                  leading: SvgPicture.asset('assets/images/icon/contact_us.svg',
                      color: colorBlack),
                  title: Text('Contact us'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            // ignore: deprecated_member_use
            child: FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              focusColor: colorPrimary_medium,
              label: Text('Logout'),
              icon: Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}
