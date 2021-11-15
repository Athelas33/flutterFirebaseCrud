import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/screens/login.dart';
import 'package:flutterfirebasecrud/screens/my_videos.dart';
import 'package:flutterfirebasecrud/screens/register.dart';
import 'package:flutterfirebasecrud/services/auth.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../functions.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // stream provider dahilinde kullanma
/*     final user = Provider.of<User>(context);
    final bool isAuthenticated = user != null; */
    return Consumer<AccountProvider>(
        builder: (context, value, _) => ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Drawer(
                    child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.010,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: size.height * 0.080,
                            width: size.height * 0.080,
                            child: Image.asset(
                              'assets/images/mylogo.png',
                              color: Colors.black87,
                            ))
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.5,
                      child: Divider(
                        thickness: 0.8,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.010,
                    ),
                    Expanded(
                        child: AnimationConfiguration.staggeredList(
                            position: 1,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: ListView(
                                      // Important: Remove any padding from the ListView.
                                      padding: EdgeInsets.zero,
                                      children: <Widget>[
                                        if (AuthService.userData?.email != null)
                                          ListTile(
                                            leading: Icon(
                                              Icons.account_box,
                                              color: Colors.blue[600],
                                            ),
                                            title: Text(
                                                AuthService.userData?.email),
                                          ),
                                        ListTile(
                                          leading: Image.asset(
                                              "assets/images/ae.jpg"),
                                          title:
                                              Text('After Effect Tasarımlarım'),
                                          onTap: () async {
                                            try {
                                              Get.to(() => VideoList());
                                            } catch (e) {}
                                          },
                                        ),
                                      ]),
                                )))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "v1.0",
                          style: TextStyle(color: Colors.black54),
                        ),
                        SizedBox(
                          width: size.width * 0.010,
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.010)
                  ],
                )),
              ),
            ));
  }
}
