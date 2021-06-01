import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_cook/constants.dart';
import 'package:easy_cook/pages/home/home_screen.dart';
import 'package:easy_cook/services/auth.dart';

import 'LoginPage.dart';

class SignUp extends StatelessWidget {
  static String screen = "SignUp";
  String _email, _password, _confpassword;
  final _auth = Auth();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an account, It's free ",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    inputFile(
                        label: "Username",
                        hint: "Enter Your Username",
                        icon: Icons.supervised_user_circle),
                    inputFile(
                        onClick: (value) {
                          _email = value;
                        },
                        label: "Email",
                        hint: "Enter Your Email",
                        icon: Icons.email),
                    inputFile(
                        onClick: (value) {
                          _password = value;
                        },
                        label: "Password",
                        obscureText: true,
                        hint: "Enter Your Password",
                        icon: Icons.lock),
                    inputFile(
                        onClick: (value) {
                          _confpassword = value;
                        },
                        label: "Confirm Password ",
                        obscureText: true,
                        hint: "Confirm Password Your Password",
                        icon: Icons.lock),
                  ],
                ),
                Builder(
                    builder: (context) => Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: FlatButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              try {
                                if (globalKey.currentState.validate()) {
                                  globalKey.currentState.save();
                                  final result = await _auth.createAccount(
                                      _email, _password);
                                  Navigator.pushNamed(
                                      context, HomeScreen.screen);
                                }
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    e.message,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              try {
                                if (_password != _confpassword) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      "Passowrd and Confirmation are not the same",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              } catch (e) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Your Password and Confirmation are not the same",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    TextButton(
                      child: Text(
                        " Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.screen);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false, hint, icon, onClick}) {
  String _error(String str) {
    switch (hint) {
      case 'Enter Your Password':
        return 'Password is not filled yet';
      case 'Enter Your Email':
        return 'Email is not filled yet';
      case 'Confirm Password Your Password':
        return 'Password is not filled yet';
      case 'Enter Your Username':
        return 'Username is not filled yet';
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _error(hint);
          }
          ;
        },
        onSaved: onClick,
        maxLines: 1,
        obscureText: obscureText,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
