import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Arimo",
          iconTheme: IconThemeData(color: Colors.blue),
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromRGBO(10, 10, 10, 1), elevation: 0.0)),
      home: MyMainPage(),
    );
  }
}
