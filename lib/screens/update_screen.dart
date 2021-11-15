import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
        builder: (context, value, _) => Scaffold(
              body: Container(
                child: Column(
                  children: [
                    Spacer(flex: 5),
                    Expanded(
                        flex: 2,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              "assets/images/mylogo.png",
                              color: Colors.black87,
                              height: 150,
                              width: 110,
                            ))),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.black87,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                            "Yenilik her zaman iyidir :) yenileniyorum..",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center)),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                        child: Row(children: [
                      Spacer(),
                      Expanded(
                          flex: 8,
                          child: TextButton(
                            onPressed: () => value.launchInBrowser(
                                "https://www.mediafire.com/file/3b1njki8z4g8xfv/EA_Blog_App.apk/file"),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Güncelle"),
                              ],
                            ),
                          )),
                      Spacer()
                    ])),
                    Spacer(flex: 5)
                  ],
                ),
              ),
            ));
  }
}
