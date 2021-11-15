import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/states/connectivity_provider.dart';
import 'package:provider/provider.dart';

class FirstConnectionApp extends StatefulWidget {
  @override
  _FirstConnectionAppState createState() => _FirstConnectionAppState();
}

class _FirstConnectionAppState extends State<FirstConnectionApp> {
  Duration twentyMillis;
  @override
  void initState() {
    twentyMillis = const Duration(seconds: 5);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ConnectivityProvider>().startObserving();
    });
    super.initState();
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    } else {
      exit(0);
    }
  }

  Future<Null> delay(int milliseconds) {
    return new Future.delayed(new Duration(milliseconds: milliseconds));
  }

  @override
  Widget build(BuildContext context) {
    context.read<ConnectivityProvider>().startObserving();
    context.read<ConnectivityProvider>().addListener(() {});
    return Scaffold(
      body: Container(
          child: AlertDialog(
        titlePadding: EdgeInsets.all(0),
        title: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: FittedBox(
                child: Text("İnternet bağlantısı algılanamadı.",
                    style: TextStyle(
                        color: Colors.black87, fontFamily: "Montserrat")),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
            child: ListBody(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                        "Lütfen internet bağlantınızın aktif olduğundan emin olunuz.",
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black87, fontFamily: "Montserrat")),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            SpinKitFadingFour(
              color: Colors.blue[700],
              size: 50,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
                child: TextButton(
              onPressed: () {
                closeApp();
              },
              child: Text(
                "Çıkış Yap",
                style: TextStyle(fontFamily: "Montserrat"),
              ),
            )),
            // MaterialButton(child:Icon(Icons.circle),on)
          ],
        )),
      )),
    );

//TextButton(style:TextButton.styleFrom(padding:EdgeInsets.only(right:14)),child:Text("Tamam",style:TextStyle(fontWeight:FontWeight.bold,color:Colors.red.shade600),),
//       onPressed:()=>context.read<ConnectivityProvider>().startObserving())
  }
}
