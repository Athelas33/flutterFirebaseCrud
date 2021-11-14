import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
            height: 70,
            width: 70,
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
            size: 50.0,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
