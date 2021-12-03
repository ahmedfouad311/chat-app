// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, constant_identifier_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, empty_catches

import 'package:chatapp/data/firestore_utils.dart';
import 'package:chatapp/data/user.dart';
import 'package:chatapp/general/utils.dart';
import 'package:chatapp/home_screen.dart';
import 'package:chatapp/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String firstName = '';
  String lastName = '';
  String userName = '';
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
              'Create Account',
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
                        firstName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your First name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        lastName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your Last name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        userName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Your User Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                          CreateAccountWithFireBaseAuth();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Create Account',
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
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

  void CreateAccountWithFireBaseAuth() async {
    try {
      showLoading(context);
      var result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // to register the user to FireStore
      hideLoading(context);
      if (result.user != null) {
        var myUser = FireStoreUser(
            id: result.user!.uid,
            // ha7ot nafs el id el ma3molo save fe el auth
            firstName: firstName,
            lastName: lastName,
            userName: userName,
            email: email);
        addUserTOFireStore(myUser).then((value) {
          provider.updateUser(myUser);
          showMessage('User Registered Successfully!', context);
          Navigator.pushReplacementNamed(context, HomeScreen.ROUTE_NAME);
        }).onError((error, stackTrace) {
          showMessage(error.toString(), context);
        });
      }
    } catch (error) {
      hideLoading(context);
      showMessage(error.toString(), context);
    }
  }
}
