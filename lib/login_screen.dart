// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, override_on_non_overriding_member, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:chatapp/data/firestore_utils.dart';
import 'package:chatapp/home_screen.dart';
import 'package:chatapp/providers/auth_provider.dart';
import 'package:chatapp/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'general/utils.dart';

class LoginScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String email = '';
  String password = '';
  bool passwordVisible = false;

  var formKey = GlobalKey<FormState>();

  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
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
              'Welcome to Chat now App',
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        email = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        if (!isValidEmail(email)) {
                          return 'Please Enter a vaild email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: !passwordVisible,
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter a password';
                        }
                        if (text.length < 6) {
                          return 'Password is too short';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passwordVisible = true;
                              });
                            },
                            child: Icon(Icons.remove_red_eye)),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          loginWithFireBaseAuth();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign In',
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.ROUTE_NAME);
                      },
                      child: Text('Or Create account !'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginWithFireBaseAuth() async {
    try {
      showLoading(context);
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      hideLoading(context);
      if (result.user != null) {
        showMessage('User logged in Successfully!', context);
        // retrieve user's data from fireBase
        var fireStoreUser = await getUserByID(result.user!.uid);
        if (fireStoreUser != null) {
          provider.updateUser(fireStoreUser);
          Navigator.pushReplacementNamed(context, HomeScreen.ROUTE_NAME);
        }
      }
    } catch (error) {
      hideLoading(context);
      showMessage('Invaild Email or Password', context);
    }
  }
}
