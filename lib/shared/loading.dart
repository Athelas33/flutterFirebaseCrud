import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterfirebasecrud/functions.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Spacer(),
          Container(
            height: size.height * 0.070,
            width: size.height * 0.070,
            child: Image.asset(
              'assets/images/mylogo.png',
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SpinKitFadingFour(
            color: Colors.black87,
            size: size.height * 0.050,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
