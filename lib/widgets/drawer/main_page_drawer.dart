import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/screens/login.dart';
import 'package:flutterfirebasecrud/screens/register.dart';
import 'package:get/get.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'athelas33@gmail.com',
            ),
          ),
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
        ]));
  }
}
