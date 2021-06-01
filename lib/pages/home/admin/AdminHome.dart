import 'dart:io';
import 'package:easy_cook/constants.dart';
import 'package:easy_cook/data/RecipeCardBundle.dart';
import 'package:easy_cook/pages/home/home_screen.dart';
import 'package:easy_cook/pages/loginpage/LoginPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_cook/data/DataFireStore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class AdminHome extends StatefulWidget {
  static String screen = 'AdminHome';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(
        admin: true,
      ),
    );
  }
}
