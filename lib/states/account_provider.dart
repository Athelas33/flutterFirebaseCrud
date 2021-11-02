import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:get/get.dart';

class AccountProvider extends ChangeNotifier {
  TextEditingController nameController,
      emailController,
      usernameController,
      passwordController,
      passwordagainController;
  User user;
  bool loading = false;
  bool isAuthenticated = false;
  FirebaseAuth auth;
  Future<User> handleSignUp(email, password, FirebaseAuth auth) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    user = result.user;
    Get.rawSnackbar(
        icon: Icon(
          Icons.check,
          color: Colors.greenAccent,
        ),
        title: "Başarılı",
        message: "Kullanıcı kaydı oluşturuldu.");

    return user;
  }

  handleSignIn(username, password, FirebaseAuth auth) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: username, password: password);
      user = result.user;

      Get.rawSnackbar(
          icon: Icon(
            Icons.check,
            color: Colors.greenAccent,
          ),
          title: "Başarılı",
          message: "Hoşgeldiniz.");

      notifyListeners();
      print("the result " + result.user.email);
      Get.offAll(() => MyMainPage());
    } catch (e, s) {
      print(e);
      print(s);
      Get.rawSnackbar(
          icon: Icon(
            Icons.remove,
            color: Colors.redAccent,
          ),
          title: "Hata",
          message: "Kullanıcı adı veya şifre hatalı.");
    }
  }
}
