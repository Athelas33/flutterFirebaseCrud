import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/drawer/main_page_drawer.dart';
import 'package:provider/provider.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key key}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  GlobalKey<ScaffoldState> _globalKey;
  @override
  void initState() {
    _globalKey = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, value, _) => SafeArea(
        child: Scaffold(
          key: _globalKey,
          drawer: MainDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Anasayfa',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  leading: ElevatedButton(
                    onPressed: () {
                      _globalKey?.currentState?.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.black87,
                    ),
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white70),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:
                                BorderSide(color: Colors.black87, width: 1)))),
                  )),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  value.isAuthenticated
                      ? Text("Hoşgeldin ")
                      : Text(
                          "Anasayfa'ya hoşgeldiniz.",
                          style: TextStyle(color: Colors.black87),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
