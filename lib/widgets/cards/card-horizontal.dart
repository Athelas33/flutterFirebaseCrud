import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/constants/Theme.dart';

import '../../functions.dart';

class CardHorizontal extends StatelessWidget {
  CardHorizontal({
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "https://via.placeholder.com/200",
  });

  final String cta;
  final String img;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height * 0.080,
        width: size.height * 0.42,
        child: Card(
          elevation: 3,
          shadowColor: NowUIColors.muted.withOpacity(0.22),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: size.height * 0.100,
                    width: size.height * 0.150,
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          bottomLeft: Radius.circular(4.0)),
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                color: NowUIColors.text,
                                fontSize: size.height * 0.014,
                                fontWeight: FontWeight.w600)),
                        Text(cta,
                            maxLines: 5,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: size.height * 0.013,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FittedBox(
                              child: Text("Devamını okuyunuz..",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: size.height * 0.012,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
