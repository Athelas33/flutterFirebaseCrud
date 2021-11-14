import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: NowUIColors.bgColorScreen,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
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
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
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
            top: 250,
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
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 2.0,
                                            mainAxisSpacing: 2.0,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          children: documents
                                              .map((doc) => InkWell(
                                                    onTap: () async {
                                                      try {
                                                        Get.to(() => VideoApp(
                                                              videoTitle: doc[
                                                                  'videotitle'],
                                                              videoUrl: doc[
                                                                  'videourl'],
                                                            ));
                                                      } catch (e) {}
                                                    },
                                                    child: CardSquare(
                                                      title: doc['videotitle'],
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
