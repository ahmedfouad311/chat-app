import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUser {
  static String collectionName = 'Users';
  String id;
  String firstName;
  String lastName;
  String userName;
  String email;

  FireStoreUser(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email});

  FireStoreUser.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            userName: json['userName'] as String,
            firstName: json['firstName'] as String,
            lastName: json['lastName'] as String,
            email: json['email'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email
    };
  }

  static CollectionReference<FireStoreUser> withConverter() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .withConverter<FireStoreUser>(
          fromFirestore: (snapshot, _) =>
              FireStoreUser.fromJson(snapshot.data()!),
          toFirestore: (fireBaseUser, _) => fireBaseUser.toJson(),
        );
  }
}
