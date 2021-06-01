import 'package:easy_cook/pages/home/admin/AddAdmin.dart';
import 'package:easy_cook/pages/loginpage/BeforeLogin.dart';
import 'package:easy_cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_cook/components/my_bottom_nav_bar.dart';
import 'package:easy_cook/pages/home/components/RecipeCard.dart';
import 'package:easy_cook/pages/home/components/body.dart';
import 'package:easy_cook/size_config.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../../constants.dart';

class HomeScreen extends StatelessWidget {
  static String screen = "HomeScreen";
  final Auth _auth = Auth();
  bool admin = false;

  HomeScreen({this.admin});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: buildAppBar(),
        body: body(),
        bottomNavigationBar: MyBottomNavBar(),
        floatingActionButton: admin == true ? SpeedDialBuilder(context) : null);
  }

  Widget SpeedDialBuilder(BuildContext context) {
    return SpeedDial(
      child: Icon(Icons.settings),
      closedBackgroundColor: Colors.green,
      closedForegroundColor: Colors.white,
      openForegroundColor: Colors.white,
      openBackgroundColor: kPrimaryColor,
      speedDialChildren: [
        SpeedDialChild(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightGreen,
          label: 'Add',
          onPressed: () {
            Navigator.pushNamed(context, AddAdmin.screen);
          },
          closeSpeedDialOnPressed: false,
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          label: 'Edit',
          onPressed: () {},
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      // On Android by default its false
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        height: size * 9,
        width: size * 9,
      ),
      actions: <Widget>[
        //IconButton(
        //icon: SvgPicture.asset("assets/icons/search.svg"),
        //onPressed: () {},
        //),
        Builder(
          builder: (context) => FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BeforeLogin()));
            },
          ),
        ),
        SizedBox(
          // It means 5 because by out defaultSize = 10
          width: SizeConfig.defaultSize * 0.5,
        )
      ],
    );
  }
}
