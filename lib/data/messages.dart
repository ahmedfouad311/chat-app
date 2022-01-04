// ignore_for_file: constant_identifier_names, unused_local_variable
import 'package:chatapp/data/rooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static const String COLLECTION_NAME = 'Messages';
  String messageId;
  String content;
  DateTime dateTime;
  String senderId;
  String senderName;

  Message(
      {required this.messageId,
      required this.content,
      required this.dateTime,
      required this.senderId,
      required this.senderName});

  Message.fromJson(Map<String, dynamic> json)
      : this(
            messageId: json['messageId'] as String,
            content: json['content'] as String,
            dateTime:
                DateTime.fromMillisecondsSinceEpoch(json['dateTime'] as int),
            senderId: json['senderId'] as String,
            senderName: json['senderName'] as String);

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'content': content,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'senderId': senderId,
      'senderName': senderName
    };
  }

  static CollectionReference<Message> withConverter(String roomId) {
    // hna ba3ml collection gdeda zai el kont ba3ml fe el with converter 3l4an 23ml create le
    // collection gdeda bas hna 2na 3ayz 23ml collection 2a5azen feha el messages bas tb2a goa
    // el doc el wa7da kol doc hayb2a goaha collection le el messages bta3tha
    return Rooms.withConverter()
        .doc(roomId)
        .collection(Message.COLLECTION_NAME)
        .withConverter<Message>(
            fromFirestore: (snapShot, _) => Message.fromJson(snapShot.data()!),
            toFirestore: (message, _) => message.toJson());
  }
}
