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
                                '????kmak istedi??inizden emin misiniz?',
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
                                        "Hay??r",
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
                                                      "Esat Aky??ld??z - ",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    FittedBox(
                                                      child: Text(
                                                        "Mobil Aplikasyon Geli??tirici",
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
                                                      " Flutter Geli??tirici",
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
                                            Text("Esat Aky??ld??z",
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
                                                      "Teknolojiye olan merak??m 8.ya????mda ba??lad??.Elbetteki ??o??u ??ocukluk ??a????nda olanlar gibi bende gamer bir ??ocuktum. :)  Mmorpg tarz?? oyunlarda ??ok fazla s??remi ge??irdim.Ke??ke bu kadar l??zumsuz ge??irmeseydik vaktimizi .." +
                                                      "\n\n" +
                                                      "En ba??ta programlama sekt??r??ne girmeden ??nce ??rkm????t??m . Acaba yapabilir miyim? . ??niversite de  algoritma  ile ilk kar????la??mamda kavrayamayaca????m?? d??????nd??m. Fakat i??in garip k??sm?? 17.ya????mda iken Gta San Andreas isimli  oyunda O??uzhan diye bir arkada????m ile server a??m????t??k . ??ki ay kadar idare edebildik ama olsun. :)  O??uzhan ile server'??m??za basit bir ??ete modu olu??turmu??tuk. Demem o ki o vakitlerde ??ok zevk alm????t??k neden yapamayay??m dedim ve bu sekt??re azim ile giri?? yapt??m. " +
                                                      "\n\n" +
                                                      "??niversite y??llar??mda en b??y??k hayalim kendi oyunumu icra edebilmekti.??lkemizde halen profesyonel oyun sekt??r??nde ne yaz??k ki iyi ??r??nlerimiz halen yok.Hayalim kendi k??lt??r??m??z?? yans??tan bir moba oyunu tasarlamakt??.Unity 3D isimli oyun motoru ile 5 ayl??k bir deneyimim oldu.Haz??r objeler dahilinde kendi araba yar?????? oyunumu yapm????t??m 3 stage bar??nd??rsa da keyif alm????t??m diyebilirim :) . Ama ne yaz??k ki bu i?? i??in minimum 8 ki??ilik ekip gerekiyor. Efor yetmedi ve s??k??l??p  b??rakt??k. :)" +
                                                      "\n\n" +
                                                      "Uzun bir s??re Ae,Sony Vegas Pro gibi video edit??rl?????? programlar??nda vakit ge??irdikten sonra.. Kendime sordu??um soru , ne yapmak istiyorsun ?" +
                                                      "\n\n" +
                                                      "Hayat??mda ge??irmi?? oldu??um belli ba??l??  manevi problemlerimden sonra bir toparlanma s??recine girdim. Psikolo??um , hayat hocam ; Neval G??zel..  k??ymetimi bilmem do??rultusunda bana ??ok yard??mc?? oldu. Sonras??nda ise '????lg??n Profes??r' lakapl?? Yal????n abim ile :) uzun  muhabbetlerin neticesinde 'Mobil Geli??tiricilik' yolunda profesyonelli??e do??ru y??nelme karar?? ald??m.   " +
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
                                              "??imdilik bu kadar ." +
                                                  "\n" +
                                                  "Hayallerimize kald??????m??z yerden devam..",
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
