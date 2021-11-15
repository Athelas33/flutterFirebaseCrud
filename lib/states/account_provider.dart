import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/functions.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountProvider extends ChangeNotifier {
  TextEditingController nameController,
      emailController,
      usernameController,
      passwordController,
      passwordagainController,
      contentController,
      titleController;

  FocusNode fcNode1, fcNode2, fcNode3;

  bool loading = true;
  String error = '';
  bool isAuthenticated = false;

  setLoading(bool status) {
    loading = status;
    notifyListeners();
  }

  void openCustomDialog(img) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      img,
                      height: size.height * 0.4,
                      width: size.height * 0.35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Divider(
                              thickness: 0.8,
                            )),
                        SizedBox(
                          width: size.width * 0.012,
                        ),
                        Expanded(
                            child: FittedBox(child: Text("Mersin / Teknopark")))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 150),
        barrierDismissible: true,
        barrierLabel: '',
        context: Get.context,
        pageBuilder: (context, animation1, animation2) {});
  }

  void updateDialog() {
    Get.dialog(AlertDialog(
      title: Row(
        children: [
          Text("Uyarı",
              style:
                  TextStyle(color: Colors.blue[700], fontFamily: "Montserrat"))
        ],
      ),
      content: new Text(
          "Güncelleme mevcut;\nBu güncellemeyi yapmak ister misiniz?",
          style: TextStyle(fontFamily: "Montserrat")),
      actions: <Widget>[
        new TextButton(
          child: new Text(
            "Tamam",
            style: TextStyle(color: Colors.blue[700], fontFamily: "Montserrat"),
          ),
          onPressed: () async {
            launchInBrowser(
                "https://www.mediafire.com/file/3b1njki8z4g8xfv/EA_Blog_App.apk/file");
          },
        ),
        new TextButton(
          child: new Text(
            "İptal",
            style: TextStyle(color: Colors.black87, fontFamily: "Montserrat"),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ));
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
