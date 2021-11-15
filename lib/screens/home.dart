import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfirebasecrud/constants/gradient_color.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:flutterfirebasecrud/main.dart';
import 'package:flutterfirebasecrud/models/mainpage_post_model.dart';
import 'package:flutterfirebasecrud/models/user_credential.dart';
import 'package:flutterfirebasecrud/screens/post_detail.dart';
import 'package:flutterfirebasecrud/services/database.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:flutterfirebasecrud/widgets/cards/card-horizontal.dart';
import 'package:flutterfirebasecrud/widgets/cards/card-small.dart';
import 'package:flutterfirebasecrud/widgets/cards/card-square.dart';
import 'package:flutterfirebasecrud/widgets/drawer/main_page_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key key}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> with TickerProviderStateMixin {
  DocumentSnapshot snapshot;
  final DatabaseService _db = DatabaseService();
  GlobalKey<ScaffoldState> _globalKey;
  final database1 = FirebaseFirestore.instance;
  Future<QuerySnapshot> mainposts;
  AnimationController _controller;
  bool _foo = true;
  double value;
  static const _curve = Curves.bounceInOut;

  @override
  void initState() {
    _globalKey = GlobalKey();
    mainposts = database1.collection('mainposts').get();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    ); //..addListener(() => setState(() {}));
    value = _controller.value;
    _animate();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (updateDialog == true) {
        context.read<AccountProvider>().updateDialog();
      }
    });

    super.initState();
  }

  void _animate() async {
    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, value, _) => WillPopScope(
        onWillPop: () async {
          if (_globalKey.currentState.isDrawerOpen) {
            Get.back();
          } else {
            showGeneralDialog(
                barrierColor: Colors.black.withOpacity(0.5),
                transitionBuilder: (context, a1, a2, widget) {
                  final curvedValue =
                      Curves.easeInOutBack.transform(a1.value) - 1.0;
                  return Transform(
                      transform: Matrix4.translationValues(
                          0.0, curvedValue * 200, 0.0),
                      child: Opacity(
                          opacity: a1.value,
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            backgroundColor: Colors.white,
                            title: FittedBox(
                              child: new Text(
                                'Çıkmak istediğinizden emin misiniz?',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            actions: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new TextButton(
                                      onPressed: () => exit(0),
                                      child: Text(
                                        "Evet",
                                        style: TextStyle(
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.020,
                                    ),
                                    new TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(
                                        "Hayır",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          )));
                },
                transitionDuration: Duration(milliseconds: 200),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (context, animation1, animation2) {});
          }
          return false;
        },
        child: SafeArea(
          child: Scaffold(
              key: _globalKey,
              drawer: MainDrawer(),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                  AppBar().preferredSize.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: AppBar(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Anasayfa',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: size.height * 0.024,
                            fontWeight: FontWeight.w400),
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
                            minimumSize:
                                MaterialStateProperty.all(Size(50, 50)),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                          animation: CurvedAnimation(
                              parent: _controller, curve: _curve),
                          builder: (context, child) {
                            return Opacity(
                                opacity: _controller.value,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.010,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue[700],
                                              gradient: mygradient,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            height: size.height * 0.13,
                                            width: size.height * 0.13,
                                            child: Center(
                                                child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Stack(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      try {
                                                        value.openCustomDialog(
                                                            'assets/images/myavatar.jpg');
                                                      } catch (e) {}
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/myavatar.jpg',
                                                      height:
                                                          size.height * 0.124,
                                                      width:
                                                          size.height * 0.124,
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Icon(
                                                        Icons.search,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              ),
                                            ))),
                                        Expanded(
                                          child: FittedBox(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: size.height * 0.020,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.020,
                                                    ),
                                                    Text(
                                                      "Esat Akyıldız - ",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        "Mobil Aplikasyon Geliştirici",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              Colors.blue[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.6,
                                                    child: Divider(
                                                      thickness: 0.7,
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height:
                                                          size.height * 0.030,
                                                      width:
                                                          size.height * 0.030,
                                                      child: Image.asset(
                                                          'assets/images/flutter_icon.jpg'),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            size.width * 0.020),
                                                    Text(
                                                      " Flutter Geliştirici",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ));
                          }),
                      SizedBox(
                        height: size.height * 0.030,
                      ),
                      Expanded(
                        flex: 2,
                        child: AnimatedBuilder(
                            animation: CurvedAnimation(
                                parent: _controller, curve: _curve),
                            builder: (context, child) {
                              return Opacity(
                                  opacity: _controller.value,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(" Merhaba, ben "),
                                            Text("Esat Akyıldız",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: size.width * 0.005),
                                            Expanded(
                                                flex: 10,
                                                child: Text(
                                                  "\n" +
                                                      "Teknolojiye olan merakım 8.yaşımda başladı.Elbetteki çoğu çocukluk çağında olanlar gibi bende gamer bir çocuktum. :)  Mmorpg tarzı oyunlarda çok fazla süremi geçirdim.Keşke bu kadar lüzumsuz geçirmeseydik vaktimizi .." +
                                                      "\n\n" +
                                                      "En başta programlama sektörüne girmeden önce ürkmüştüm . Acaba yapabilir miyim? . Üniversite de  algoritma  ile ilk karşılaşmamda kavrayamayacağımı düşündüm. Fakat işin garip kısmı 17.yaşımda iken Gta San Andreas isimli  oyunda Oğuzhan diye bir arkadaşım ile server açmıştık . İki ay kadar idare edebildik ama olsun. :)  Oğuzhan ile server'ımıza basit bir çete modu oluşturmuştuk. Demem o ki o vakitlerde çok zevk almıştık neden yapamayayım dedim ve bu sektöre azim ile giriş yaptım. " +
                                                      "\n\n" +
                                                      "Üniversite yıllarımda en büyük hayalim kendi oyunumu icra edebilmekti.Ülkemizde halen profesyonel oyun sektöründe ne yazık ki iyi ürünlerimiz halen yok.Hayalim kendi kültürümüzü yansıtan bir moba oyunu tasarlamaktı.Unity 3D isimli oyun motoru ile 5 aylık bir deneyimim oldu.Hazır objeler dahilinde kendi araba yarışı oyunumu yapmıştım 3 stage barındırsa da keyif almıştım diyebilirim :) . Ama ne yazık ki bu iş için minimum 8 kişilik ekip gerekiyor. Efor yetmedi ve sıkılıp  bıraktık. :)" +
                                                      "\n\n" +
                                                      "Uzun bir süre Ae,Sony Vegas Pro gibi video editörlüğü programlarında vakit geçirdikten sonra.. Kendime sorduğum soru , ne yapmak istiyorsun ?" +
                                                      "\n\n" +
                                                      "Hayatımda geçirmiş olduğum belli başlı  manevi problemlerimden sonra bir toparlanma sürecine girdim. Psikoloğum , hayat hocam ; Neval Güzel..  kıymetimi bilmem doğrultusunda bana çok yardımcı oldu. Sonrasında ise 'Çılgın Profesör' lakaplı Yalçın abim ile :) uzun  muhabbetlerin neticesinde 'Mobil Geliştiricilik' yolunda profesyonelliğe doğru yönelme kararı aldım.   " +
                                                      "\n\n",
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                )),
                                            SizedBox(width: size.width * 0.005),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Şimdilik bu kadar ." +
                                                  "\n" +
                                                  "Hayallerimize kaldığımız yerden devam..",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                      SizedBox(height: size.height * 0.010),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Divider(
                          thickness: 0.3,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: size.height * 0.020),
                      Expanded(
                        child: FutureBuilder<QuerySnapshot>(
                            future: mainposts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<DocumentSnapshot> documents =
                                    snapshot.data.docs;
                                return ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: documents
                                        .map((doc) => InkWell(
                                              onTap: () async {
                                                Get.to(() => PostDetail(
                                                      img: doc['image2'],
                                                      article: doc['content'],
                                                      title: doc['title'],
                                                      article2: doc['content2'],
                                                    ));
                                              },
                                              child: CardHorizontal(
                                                cta: doc['content'],
                                                title: doc['title'],
                                                img: doc['image'],
                                              ),
                                            ))
                                        .toList());
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error);
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ),
                      SizedBox(height: size.height * 0.050)
                    ],
                  ))),
        ),
      ),
    );
  }
}
