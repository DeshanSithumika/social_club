import 'package:flutter/material.dart';
import 'package:social_club/resources/auth_methods.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();


    _user = user;
    notifyListeners();
  }
  User get getUser => _user!;
}
