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

  final Observable<bool> _isLoading = Observable<bool>(false);
  bool get isLoading => _isLoading.value;

  void _setLoading() {
    _isLoading.value = true;
  }

  void _setNotLoading() {
    _isLoading.value = false;
  }

  void _revertValueLoading() {
    _isLoading.value = !_isLoading.value;
  }

  Future<bool> login(String username, String password) async {
    revertValueLoading.call();
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      revertValueLoading.call();
    });

    if (username.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
