import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/widgets/drawer/main_page_drawer.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  GlobalKey<ScaffoldState>? _globalKey;
  @override
  void initState() {
    _globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: GestureDetector(
            onTap: () {
              _globalKey?.currentState?.openDrawer();
            },
            child: Icon(Icons.menu)),
        actions: [
          Icon(Icons.notifications),
          SizedBox(
            width: 10,
          )
        ],
        title: Center(
          child: Text(
            "Anasayfa",
            textAlign: TextAlign.center,
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Anasayfa'ya hoşgeldiniz.")],
          )
        ],
      ),
    );
  }
}
