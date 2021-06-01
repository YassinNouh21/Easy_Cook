import 'dart:io';

import 'package:easy_cook/data/DataFireStore.dart';
import 'package:easy_cook/data/RecipeCardBundle.dart';
import 'package:easy_cook/pages/home/components/RecipeCard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../../../constants.dart';
import '../home_screen.dart';

class AddAdmin extends StatefulWidget {
  static String screen = "AddAdmin";

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  File image;
  final picker = ImagePicker();
  pickPhoto() async {
    var imageThatPicked =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageThatPicked != null) {
      setState(() {
        image = File(imageThatPicked.path);
        uploadPhoto();
      });
    }
  }

  void uploadPhoto() async {
    FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://test-193e1.appspot.com');
    StorageReference ref = storage.ref().child(image.path);
    StorageUploadTask storageUploadTask = ref.putFile(image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String urlOfPhoto = await taskSnapshot.ref.getDownloadURL();
    url = urlOfPhoto;
  }

  String rate = "0";
  String title, how, time, ingredients, place, url;
  DataFireStore f1 = DataFireStore();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  // static RecipeCardBundle r1 = RecipeCardBundle();
  // final url = r1.youtubeURL;
  // YoutubePlayerController _controller = YoutubePlayerController(
  //     initialVideoId: YoutubePlayer.convertUrlToId(url));

  @override
  Widget build(BuildContext context) {
    RecipeCardBundle r1 = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: SafeArea(
          child: Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  image == null
                      ? Text("no image was found")
                      : Container(
                          child: Image.file(
                            image,
                          ),
                          height: 180,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 10,
                                color: Color(0xFF84AB5C),
                              ),
                              borderRadius: BorderRadius.circular(2)),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: textAdd(
                        label: "",
                        hint: 'Enter Title of the Recipe',
                        line: 1,
                        onSave: (value) {
                          title = value;
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: textAdd(
                        onSave: (value) {
                          time = value;
                        },
                        line: 1,
                        hint: 'Enter Time',
                        label: ""),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: textAdd(
                        label: "",
                        line: 1,
                        onSave: (value) {
                          place = value;
                        },
                        hint: 'Enter Place'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: textAdd(
                        label: "",
                        line: null,
                        onSave: (value) {
                          ingredients = value;
                        },
                        hint: 'Enter the ingredients'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: textAdd(
                        label: "Enter how to cook it",
                        line: null,
                        onSave: (value) {
                          setState(() {
                            how = value;
                          });
                        },
                        hint: 'Enter how to cook it'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: FlatButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        try {
                          if (globalKey.currentState.validate()) {
                            globalKey.currentState.save();
                            await f1.add(RecipeCardBundle(
                                time: time,
                                ingredient: ingredients,
                                titleOfRecipe: title,
                                place: place,
                                howToCookIt: how,
                                rating: rate,
                                thumbnailUrl: url));
                            // Navigator.pushNamed(
                            //     context, HomeScreen.screen);
                          }
                          image = null;
                          globalKey.currentState.reset();
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
                      },
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Add Recipe",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: pickPhoto,
          backgroundColor: Colors.blue,
          focusColor: Colors.white,
          child: Icon(Icons.camera_alt),
        ));
  }

  TextFormField textAdd({label, hint, line, onSave}) {
    label = hint;
    String _error(String str) {
      switch (hint) {
        case 'Enter Title of the Recipe':
          return ' Title is not filled yet ';
        case 'Enter Time':
          return 'Time is not filled yet';
        case 'Enter the ingredients':
          return 'No ingredients are not filled yet';
        case 'Enter how to cook it':
          return 'how to cook it is not filled yet';
        case 'Enter Place':
          return 'Place is not filled yet';
      }
    }

    return TextFormField(
      onSaved: onSave,
      maxLines: line,
      decoration: new InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: hint,
        labelText: hint,
        fillColor: Color(0xFF202E2E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return _error(hint);
        }
        ;
      },
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
// SpeedDial(
// openBackgroundColor: Colors.blue,
// child: Icon(
// Icons.settings,
// size: 30,
// ),
// openForegroundColor: null,
// closedForegroundColor: Colors.blue,
// closedBackgroundColor: Colors.white,
// speedDialChildren: [
// SpeedDialChild(
// onPressed: () {},
// backgroundColor: Colors.amber,
// foregroundColor: Colors.yellow,
// child: Icon(Icons.camera),
// closeSpeedDialOnPressed: false,
// label: 'add photo')
// ],
// ),
