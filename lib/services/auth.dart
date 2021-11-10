import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecrud/models/user_credential.dart';
import 'package:flutterfirebasecrud/screens/home.dart';
import 'package:flutterfirebasecrud/services/database.dart';
import 'package:flutterfirebasecrud/states/account_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

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

  handleSignUp(email, password, name) async {
    accountprovider.setLoading(false);
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(result);
      await _db.registerUser(result.user.uid, email, name);
      await _auth.signOut();
      Get.rawSnackbar(
          icon: Icon(
            Icons.check,
            color: Colors.greenAccent,
          ),
          title: "Başarılı",
          message: "Kullanıcı kaydı oluşturuldu.");

      // Get.offAll(() => MyMainPage());
      accountprovider.setLoading(true);
    } catch (e, s) {
      print(s);
      print(e);
      Get.rawSnackbar(
          icon: Icon(
            Icons.error,
            color: Colors.redAccent,
          ),
          title: "Hata",
          message: e.toString());
      accountprovider.setLoading(true);
    }
  }
}
