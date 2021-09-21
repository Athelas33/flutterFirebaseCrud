import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterProvider extends ChangeNotifier {
  Future<User> handleSignUp(email, password, FirebaseAuth auth) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    Get.rawSnackbar(
        icon: Icon(
          Icons.check,
          color: Colors.greenAccent,
        ),
        title: "Başarılı",
        message: "Kullanıcı kaydı oluşturuldu.");

    return user;
  }
}
