import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider with ChangeNotifier {
  Connectivity _connectivity = new Connectivity();
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  void startObserving() async {
    await initConnetctivity();
    _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  Future<void> initConnetctivity() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
        debugPrint("internet yok");
      } else {
        _isOnline = true;
        notifyListeners();
        debugPrint("internet var");
      }
    } on PlatformException catch (e) {}
  }
}
