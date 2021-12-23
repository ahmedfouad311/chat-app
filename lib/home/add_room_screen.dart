// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_unnecessary_containers

import 'package:chatapp/general/utils.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Add Room Screen';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  Category selectedCategory = categories[0];

  String roomName = '';

  String description = '';

  var formKey = GlobalKey<FormState>();

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
            body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07,
                  vertical: MediaQuery.of(context).size.height * 0.06),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create New Room',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset('assets/images/group.png'),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (text) {
                          text = roomName;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Room Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Room Name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      DropdownButtonFormField<Category>(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                        value: selectedCategory,
                        items: categories
                            .map<DropdownMenuItem<Category>>((category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Row(
                              children: [
                                Image.asset(category.imagePath,
                                    height: 45, width: 45),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  category.name,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        maxLines: 3,
                        minLines: 3,
                        onChanged: (text) {
                          text = description;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Room Description',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 53, 152, 219))),
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {}
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Create',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
