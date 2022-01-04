// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatapp/chat/chat_details_screen.dart';
import 'package:chatapp/home/add_room_screen.dart';
import 'package:chatapp/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';
import 'login_register/login_screen.dart';
import 'login_register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) {
        return AuthProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        RegisterScreen.ROUTE_NAME: (context) => RegisterScreen(),
        LoginScreen.ROUTE_NAME: (context) => LoginScreen(),
        AddRoomScreen.ROUTE_NAME: (context) => AddRoomScreen(),
        ChatDetailsScreen.ROUTE_NAME: (context) => ChatDetailsScreen(),
      },
      initialRoute: provider.isLoggedIn()
          ? HomeScreen.ROUTE_NAME
          : LoginScreen.ROUTE_NAME,
    );
  }
}
