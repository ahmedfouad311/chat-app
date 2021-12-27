// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, empty_constructor_bodies

import 'package:flutter/material.dart';

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

void showMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('ok'),
          ),
        ],
      );
    },
  );
}

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 12,
            ),
            Text('Loading...'),
          ],
        ),
      );
    },
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

class Category {
  static const String MUSIC_ID = 'music';
  static const String SPORTS_ID = 'sports';
  static const String MOVIES_ID = 'movies';

  late String id;
  late String name;
  late String imagePath;

  Category(this.id, this.name, this.imagePath);

  Category.fromId(String id){
    if (id == MUSIC_ID) {
      id = MUSIC_ID;
      name = 'Music';
      imagePath = 'assets/images/music.jpg';
    }
    else if (id == SPORTS_ID) {
      id = SPORTS_ID;
      name = 'Sports';
      imagePath = 'assets/images/sports.png';
    }
    else if (id == MOVIES_ID) {
      id = MOVIES_ID;
      name = 'Movies';
      imagePath = 'assets/images/movie.png';
    }
  }
}

List<Category> categories = [
  Category.fromId(Category.SPORTS_ID),
  Category.fromId(Category.MOVIES_ID),
  Category.fromId(Category.MUSIC_ID),
];
