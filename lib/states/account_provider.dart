import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  TextEditingController nameController,
      emailController,
      usernameController,
      passwordController,
      passwordagainController;

  bool loading = true;
  String error = '';
  bool isAuthenticated = false;

  setLoading(bool status) {
    loading = status;
    notifyListeners();
  }
}
