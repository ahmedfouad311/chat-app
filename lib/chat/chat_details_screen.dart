// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, must_be_immutable, avoid_unnecessary_containers

import 'package:chatapp/chat/message_widget.dart';
import 'package:chatapp/data/firestore_utils.dart';
import 'package:chatapp/data/messages.dart';
import 'package:chatapp/data/rooms.dart';
import 'package:chatapp/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailsScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Chat Details Screen';

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late Rooms rooms;
  late AuthProvider provider;
  String message = '';

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
    rooms = ModalRoute.of(context)!.settings.arguments as Rooms;
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/pattern.png'),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              rooms.roomName,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: MediaQuery.of(context).size.height * 0.06),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(color: Colors.grey, offset: Offset(4, 4)),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: Message.withConverter(rooms.roomId)
                        .orderBy('dateTime', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error While loading Messages'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('There are no Messages Yet'));
                      }
                      var messagesList =
                          snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MessageWidget(messagesList[index]);
                        },
                        itemCount: messagesList.length,
                      );
                    },
                  ),
                )),
                SizedBox(
                  height: 15,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(text: message),
                        onChanged: (text) {
                          message = text;
                        },
                        decoration: InputDecoration(
                          hintText: 'Type Your Message: ',
                          // focusedBorder:  OutlineInputBorder(
                          //   borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                          //   borderSide: BorderSide(color: Colors.grey)
                          // ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        sendMessage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.send)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage() async {
    Message m = Message(
        messageId: '',
        content: message,
        dateTime: DateTime.now(),
        senderId: provider.user!.id,
        senderName: provider.user!.userName);
    var result = await addMessagesToEachRoom(m, rooms.roomId);
    setState(() {
      message = '';
    });
  }
}
