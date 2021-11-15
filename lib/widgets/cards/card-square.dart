import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/constants/Theme.dart';
import 'package:flutterfirebasecrud/functions.dart';

class CardSquare extends StatelessWidget {
  CardSquare({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "https://via.placeholder.com/200",
  });

  final String cta;
  final String img;

  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.29,
        width: null,
        child: Card(
            elevation: 3,
            shadowColor: NowUIColors.muted.withOpacity(0.22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Image.network(
                      img,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SpinKitFadingFour(
                            color: Colors.blue[700],
                            size: size.height * 0.050,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          FittedBox(
                            child: Text(title,
                                style: TextStyle(
                                  color: NowUIColors.text,
                                )),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
