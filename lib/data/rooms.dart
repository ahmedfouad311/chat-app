// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Rooms {
  static const String COLLECTION_NAME = 'Rooms';
  String roomId;
  String roomName;
  String description;
  String categoryId;

  Rooms(
      {required this.roomId,
      required this.roomName,
      required this.description,
      required this.categoryId});

  Rooms.fromJson(Map<String, dynamic> json)
      : this(
          roomId: json['roomId'] as String,
          roomName: json['roomName'] as String,
          description: json['description'] as String,
          categoryId: json['categoryId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomName': roomName,
      'description': description,
      'categoryId': categoryId,
    };
  }

  static CollectionReference<Rooms> withConverter() {
    return FirebaseFirestore.instance.collection(COLLECTION_NAME).withConverter(
        fromFirestore: (snapShot, _) => Rooms.fromJson(snapShot.data()!),
        toFirestore: (room, _) => room.toJson());
  }
}
