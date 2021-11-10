import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/models/mainpage_post_model.dart';
import 'package:flutterfirebasecrud/services/database.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/cards/card-horizontal.dart';
import 'package:flutterfirebasecrud/widgets/drawer/main_page_drawer.dart';
import 'package:provider/provider.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key key}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  final DatabaseService _db = DatabaseService();
  GlobalKey<ScaffoldState> _globalKey;
  @override
  void initState() {
    _globalKey = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<MainPost>>(context) ?? [];
    print(posts);
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
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Colors.black87, width: 1)))),
                    )),
              ),
            ),
            body: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: CardHorizontal(
                                    cta: "Devamını okuyun",
                                    title: posts[index].title,
                                    img: posts[index].image,
                                    tap: () {}),
                              );
                            }))
                  ],
                ))),
      ),
    );
  }
}
