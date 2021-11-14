import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/constants/Theme.dart';
import 'package:flutterfirebasecrud/functions.dart';

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
                widget.img,
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
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, right: 32.0, top: 42.0),
                        child: Column(children: [
                          Text(widget.title,
                              style: TextStyle(
                                  color: NowUIColors.text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.0)),
                          SizedBox(height: size.height * 0.020),
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
                          SingleChildScrollView(
                            child: Text(widget.article2,
                                style: TextStyle(color: NowUIColors.black)),
                          )
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
