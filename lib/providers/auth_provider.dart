// ignore_for_file: avoid_init_to_null

import 'package:chatapp/data/user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  FireStoreUser? user = null;

  void updateUser(FireStoreUser user) {
    this.user = user;
    notifyListeners();
  }
}
