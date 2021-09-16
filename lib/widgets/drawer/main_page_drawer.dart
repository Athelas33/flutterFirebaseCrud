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
      elevation: 7,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.black87),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Drawer başlığı",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
          ),
          InkWell(
            onTap: () => Get.to(() => RegisterPage()),
            child: ListTile(
              title: Text("Kayıt ol"),
              leading: Icon(Icons.account_circle),
            ),
          ),
          InkWell(
            onTap: () => Get.to(() => LoginPage()),
            child: ListTile(
              title: Text("Giriş Yap"),
              leading: Icon(Icons.login),
            ),
          )
        ],
      ),
    );
  }
}
