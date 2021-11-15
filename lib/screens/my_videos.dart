import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/constants/Theme.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:flutterfirebasecrud/screens/post_detail.dart';
import 'package:flutterfirebasecrud/screens/video_player.dart';
import 'package:flutterfirebasecrud/widgets/cards/card-square.dart';
import 'package:get/get.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key key}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  Future<QuerySnapshot> mainposts;
  final database1 = FirebaseFirestore.instance;

  @override
  void initState() {
    mainposts = database1.collection('videos').get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            AppBar().preferredSize.height,
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Tasarımlar",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.height * 0.024,
                        fontWeight: FontWeight.w400),
                  ),
                  leading: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_left,
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
                  )))),
      backgroundColor: NowUIColors.bgColorScreen,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              height: size.height * 0.3,
              width: double.infinity,
              child: Image.network(
                "https://wallpaperaccess.com/full/3953916.jpg",
                fit: BoxFit.scaleDown,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Column(
                    children: [
                      Spacer(),
                      Center(
                        child: SpinKitFadingFour(
                          color: Colors.blue[700],
                        ),
                      ),
                      Spacer()
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.25,
            right: 0,
            bottom: 0,
            left: 0,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, right: 32.0, top: 42.0),
                        child: Column(children: [
                          Expanded(
                            child: Container(
                              child: FutureBuilder<QuerySnapshot>(
                                  future: mainposts,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final List<DocumentSnapshot> documents =
                                          snapshot.data.docs;
                                      return AnimatedSwitcher(
                                        duration: Duration(seconds: 1),
                                        child: GridView(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 2.0,
                                              mainAxisSpacing: 2.0,
                                            ),
                                            scrollDirection: Axis.vertical,
                                            children: documents
                                                .map((doc) => InkWell(
                                                      onTap: () async {
                                                        try {
                                                          Get.to(
                                                              () => VideoDemo(
                                                                    url: doc[
                                                                        'videourl'],
                                                                  ));
                                                        } catch (e) {}
                                                      },
                                                      child: CardSquare(
                                                        title:
                                                            doc['videotitle'],
                                                        img: doc['videoimg'],
                                                      ),
                                                    ))
                                                .toList()),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error);
                                    }
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }),
                            ),
                          ),
                        ]),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
