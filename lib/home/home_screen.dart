// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable

import 'package:chatapp/data/rooms.dart';
import 'package:chatapp/home/add_room_screen.dart';
import 'package:chatapp/home/room_grid_item.dart';
import 'package:chatapp/login_register/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'Home Screen';
  List<Rooms>? roomsList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/pattern.png'),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Chat Now App',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          drawer: Drawer(
            child: Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 53, 152, 219),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 48),
                    width: double.infinity,
                    child: Text('Chat Now App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.ROUTE_NAME);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 36,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Logout',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 53, 152, 219),
              shape: StadiumBorder(
                // el border el 7awalen el button
                side: BorderSide(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.ROUTE_NAME);
              }),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 120, bottom: 12, left: 12, right: 12),
            child: StreamBuilder<QuerySnapshot<Rooms>>(
              stream: Rooms.withConverter().snapshots(),
              builder: (builder, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.hasError.toString()));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    'No Rooms Joined Yet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
                }
                roomsList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.9 / 1),
                  itemBuilder: (context, index) {
                    return RoomGridItem(roomsList!.elementAt(index));
                  },
                  itemCount: roomsList?.length ?? 0,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
