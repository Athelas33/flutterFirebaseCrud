import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/constants/Theme.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:get/get.dart';

class PostDetail extends StatefulWidget {
  final String article;
  final String title;
  final String img;
  final String article2;

  const PostDetail({Key key, this.article, this.article2, this.img, this.title})
      : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
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
                    widget.title,
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
                widget.img,
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
            top: size.height * 0.2,
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
                      child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 32.0, right: 32.0, top: 30.0),
                            child: Column(children: [
                              SizedBox(height: size.height * 0.005),
                              Text(widget.article,
                                  style: TextStyle(color: NowUIColors.time)),
                              SizedBox(height: size.height * 0.020),
                              SizedBox(
                                width: size.width * 0.5,
                                child: Divider(
                                  thickness: 0.3,
                                  color: Colors.black45,
                                ),
                              ),
                              SizedBox(height: size.height * 0.020),
                              Text(widget.article2,
                                  style: TextStyle(color: NowUIColors.black)),
                              SizedBox(height: size.height * 0.020),
                            ]),
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
