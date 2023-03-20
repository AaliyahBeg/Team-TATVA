import 'package:flutter/widgets.dart';
import 'package:environment_app/Connect/components/models/user.dart';
import 'package:environment_app/services/authFunctions.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthServices _authServices = AuthServices();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authServices.getUserDetails();
    _user = user;
    notifyListeners();
  }
}