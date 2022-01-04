// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors

import 'package:chatapp/data/messages.dart';
import 'package:chatapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  late AuthProvider provider;
  Message message;
  MessageWidget(this.message);
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: message.senderId == provider.user?.id
            ? SentMessage(message.content, message.dateTime.toString())
            : RecievedMessage(message.content, message.dateTime.toString(),
                message.senderName));
  }
}

class SentMessage extends StatelessWidget {
  String content;
  String time;
  SentMessage(this.content, this.time);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            time,
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 53, 152, 219),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(0)),
          ),
          child: Text(
            content,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class RecievedMessage extends StatelessWidget {
  String content;
  String time;
  String senderName;
  RecievedMessage(this.content, this.time, this.senderName);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            senderName,
            style: TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(0),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                child: Text(
                  content,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(time),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
