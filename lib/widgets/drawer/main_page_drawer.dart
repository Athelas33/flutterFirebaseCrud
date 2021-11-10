import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/screens/login.dart';
import 'package:flutterfirebasecrud/screens/new_post.dart';
import 'package:flutterfirebasecrud/screens/register.dart';
import 'package:flutterfirebasecrud/services/auth.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // stream provider dahilinde kullanma
/*     final user = Provider.of<User>(context);
    final bool isAuthenticated = user != null; */
    return Consumer<AccountProvider>(
        builder: (context, value, _) => Drawer(
            child: value.isAuthenticated
                ? Column(
                    children: [
                      Expanded(
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
                                  title: Text(AuthService.userData?.email),
                                ),
                              Divider(
                                thickness: 1.3,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.social_distance,
                                  color: Colors.blue[600],
                                ),
                                title: Text('Sosyal Medya'),
                                onTap: () async {
                                  try {} catch (e) {}
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.work_outlined,
                                  color: Colors.blue[600],
                                ),
                                title: Text('E-Ticaret'),
                                onTap: () async {
                                  try {} catch (e) {}
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.web_stories,
                                  color: Colors.blue[600],
                                ),
                                title: Text('Web Yazılım'),
                                onTap: () async {
                                  try {} catch (e) {}
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.mobile_screen_share,
                                  color: Colors.blue[600],
                                ),
                                title: Text('Mobil Uygulama'),
                                onTap: () async {
                                  try {} catch (e) {}
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.add,
                                  color: Colors.blue[600],
                                ),
                                title: Text('Yeni Post'),
                                onTap: () async {
                                  try {
                                    Get.to(() => NewPostPage());
                                  } catch (e) {}
                                },
                              ),
                            ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
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
                          ),
                        ],
                      ),
                    ],
                  )
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
