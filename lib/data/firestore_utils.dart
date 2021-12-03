import 'package:chatapp/data/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUserTOFireStore(FireStoreUser user) {
  return FireStoreUser.withConverter()
      .doc(user.id)
      .set(user); // ba3ml create le doc gdeda
}

Future<FireStoreUser?> getUserByID(String userId) async {
  DocumentSnapshot<FireStoreUser> result =
      await FireStoreUser.withConverter().doc(userId).get();
  return result.data();
}
