import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/screens/login.dart';
import 'package:flutterfirebasecrud/screens/register.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
        builder: (context, value, _) => Drawer(
            child: value.isAuthenticated
                ? ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.logout_outlined,
                            color: Colors.blue[600],
                          ),
                          title: Text('Çıkış Yap'),
                          onTap: () async {
                            try {
                              FirebaseAuth.instance.signOut();
                              Get.offAll(() => MyMainPage());
                            } catch (e) {}
                          },
                        ),
                      ])
                : ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                        Divider(
                          height: 1,
                          thickness: 0.5,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.blue[600],
                          ),
                          title: Text(
                            'Kayıt ol',
                          ),
                          onTap: () => Get.to(() => RegisterPage()),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.logout_outlined,
                            color: Colors.blue[600],
                          ),
                          title: Text('Giriş Yap'),
                          onTap: () => Get.to(() => LoginPage()),
                        ),
                      ])));
  }
}
