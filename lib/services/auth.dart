import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/models/user_credential.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User userObject;
  static UserModel userData = UserModel();
  var accountprovider = Provider.of<AccountProvider>(Get.context, listen: true);

  _userFromFirebase(User user) {
    return user != null ? userData.uid = user.uid : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  handleSignIn(username, password) async {
    accountprovider.setLoading(false);
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      userObject = result.user;

      Get.rawSnackbar(
          icon: Icon(
            Icons.check,
            color: Colors.greenAccent,
          ),
          title: "Başarılı",
          message: "Hoşgeldiniz.");

      userData.uid = result.user.uid;
      userData.email = result.user.email;
      userData.name = result.user.displayName;
      accountprovider.setLoading(true);
      Get.offAll(() => MyMainPage());
    } catch (e) {
      print(e);

      Get.rawSnackbar(
          icon: Icon(
            Icons.remove,
            color: Colors.redAccent,
          ),
          title: "Hata",
          message: "Kullanıcı adı veya şifre hatalı.");
      accountprovider.setLoading(true);
    }
  }

  handleSignUp(email, password) async {
    accountprovider.setLoading(false);
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Get.rawSnackbar(
          icon: Icon(
            Icons.check,
            color: Colors.greenAccent,
          ),
          title: "Başarılı",
          message: "Kullanıcı kaydı oluşturuldu.");

      accountprovider.setLoading(true);
      print(result);
      Get.back();
    } catch (e) {
      print(e);
      accountprovider.setLoading(true);
    }
  }
}
