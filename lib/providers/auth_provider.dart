// ignore_for_file: avoid_init_to_null

import 'package:chatapp/data/firestore_utils.dart';
import 'package:chatapp/data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // el provider hna by5azen el user el hageb o mn el register 2w el login screen 3l4an 23raf
  // 2sta5demo fe ba2i el screens yb2a mt5azen 3andi fe el provider
  FireStoreUser? user = null;

  AuthProvider() {
    fetchFireStoreUser();
  }

  void updateUser(FireStoreUser user) {
    this.user = user;
    notifyListeners();
  }

  void fetchFireStoreUser() async {
    // de btgeb el current user mn el database
    if (FirebaseAuth.instance.currentUser != null) {
      var fireStoreUser = await getUserByID(
          FirebaseAuth.instance.currentUser!.uid);
      user = fireStoreUser;
    }
  }

  bool isLoggedIn() {
    // de 3l4an law 2na already kont 3aml login abl keda ywadeni 3ala toll le el home screen
    // lma 2fta7 el app w dah el 2na 3amalto fe el main screen fe el initial route
    return FirebaseAuth.instance.currentUser != null;
  }
}
