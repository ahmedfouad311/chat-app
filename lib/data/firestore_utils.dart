import 'package:chatapp/data/messages.dart';
import 'package:chatapp/data/rooms.dart';
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

Future<void> addRoomToFireStore(Rooms rooms) {
  var docRef = Rooms.withConverter().doc();

  rooms.roomId = docRef.id;
  return docRef.set(rooms);
}

Future<void> addMessagesToEachRoom(Message message, String roomId) {
  var docRef = Message.withConverter(roomId).doc();

  message.messageId = docRef.id;
  return docRef.set(message);
}
