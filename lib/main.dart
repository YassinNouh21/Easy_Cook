import 'package:easy_cook/provider/admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_cook/constants.dart';
import 'package:easy_cook/data/NavItem.dart';
import 'package:easy_cook/pages/home/home_screen.dart';
import 'package:easy_cook/pages/loginpage/BeforeLogin.dart';
import 'package:easy_cook/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavItems()),
        ChangeNotifierProvider(create: (context) => admin()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipe App',
        theme: ThemeData(
          // backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BeforeLogin(),
        initialRoute: BeforeLogin.screen,
        routes: routes,
      ),
    );
  }
}
