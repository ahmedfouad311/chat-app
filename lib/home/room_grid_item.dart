// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:chatapp/chat/chat_details_screen.dart';
import 'package:chatapp/data/rooms.dart';
import 'package:chatapp/general/utils.dart';
import 'package:flutter/material.dart';

class RoomGridItem extends StatelessWidget {
  Rooms rooms;
  RoomGridItem(this.rooms);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatDetailsScreen.ROUTE_NAME,
            arguments: rooms);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(4, 4))],
        ),
        child: Column(
          children: [
            Image.asset(Category.fromId(rooms.categoryId).imagePath,
                height: 80, width: double.infinity),
            Text(
              rooms.roomName,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
