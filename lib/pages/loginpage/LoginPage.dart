import 'package:easy_cook/pages/home/admin/AddAdmin.dart';
import 'package:easy_cook/pages/home/admin/AdminHome.dart';
import 'package:easy_cook/pages/loginpage/SignUp.dart';
import 'package:easy_cook/provider/admin.dart';
import 'package:easy_cook/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_cook/constants.dart';
import 'package:easy_cook/pages/home/home_screen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static String screen = "LoginPage";
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final _auth = Auth();
  String _password, _email;
  String _adminPassword = "adminadmin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Form(
        key: globalKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(
                            onSave: (value) {
                              _email = value;
                            },
                            label: "Email",
                            hint: "Enter Your Email Here...",
                            icon: Icons.email),
                        inputFile(
                            onSave: (value) {
                              _password = value;
                            },
                            label: "Password",
                            obscureText: true,
                            hint: "Enter Your Password Here...",
                            icon: Icons.lock)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: Builder(
                        builder: (context) => MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            if (globalKey.currentState.validate()) {
                              globalKey.currentState.save();
                              try {
                                if (_password == _adminPassword) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminHome()),
                                    (Route<dynamic> route) => false,
                                  );
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
                                final result =
                                    await _auth.logIn(_email, _password);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false,
                                );
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
                            }
                          },
                          color: kPrimaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      TextButton(
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: kPrimaryColor),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignUp.screen);
                        },
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 200,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputFile({label, obscureText = false, hint, icon, onSave}) {
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
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          onSaved: onSave,
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
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
