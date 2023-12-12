import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

class AuthService {
  late Action setLoading;
  late Action setNotLoading;
  late Action revertValueLoading;

  AuthService() {
    setLoading = Action(_setLoading);
    setNotLoading = Action(_setNotLoading);
    revertValueLoading = Action(_revertValueLoading);
  }

  // ignore: prefer_final_fields
  Observable<bool> _isLoading = Observable<bool>(false);
  bool get isLoading => _isLoading.value;

  void _setLoading() {
    if (kDebugMode) {
      print('_setLoading');
    }
    _isLoading.value = true;
  }

  void _setNotLoading() {
    if (kDebugMode) {
      print('_setNotLoading');
    }
    _isLoading.value = false;
  }

  void _revertValueLoading() {
    if (kDebugMode) {
      print('_revertValueLoading');
    }
    _isLoading.value = !_isLoading.value;
  }

  Future<bool> login(String username, String password) async {
    revertValueLoading.call();
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      revertValueLoading.call();
    });

    if (username == 'usuarioteste' && password == 'senhateste') {
      return true;
    } else {
      return false;
    }
  }
}
