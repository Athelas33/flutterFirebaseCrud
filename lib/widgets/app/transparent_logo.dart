import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLogoDialog(bool isOk) async {
  Size size = MediaQuery.of(Get.context).size;
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    if (isOk == false) {
      showGeneralDialog(
          context: Get.context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            // Get available height and width of the build area of this widget. Make a choice depending on the size.

            return Center(
              child: Stack(
                children: [
                  Align(
                      child: SizedBox(
                          width: size.height * 0.155,
                          height: size.height * 0.155,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            color: Colors.white,
                          ))),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/mylogo.png",
                        color: Colors.white,
                        height: size.height * 0.150,
                        width: size.height * 0.110,
                      )),
                ],
              ),
            );
          },
          barrierDismissible: false,
          barrierLabel:
              MaterialLocalizations.of(Get.context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 150));
    }
  });
  if (isOk == true) {
    Get.back();
  }
}
