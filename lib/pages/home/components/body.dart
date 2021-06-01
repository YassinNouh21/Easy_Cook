import 'package:easy_cook/data/DataFireStore.dart';
import 'package:flutter/material.dart';
import 'package:easy_cook/data/RecipeCardBundle.dart';
import 'package:easy_cook/pages/home/components/RecipeCard.dart';
import 'package:easy_cook/pages/recipe_details/RecipeDetailsScreen.dart';
import '../../../size_config.dart';
import 'categories.dart';

class body extends StatefulWidget {
  @override
  _bodyState createState() => _bodyState();
}

// ignore: camel_case_types
class _bodyState extends State<body> {
  final _f1 = DataFireStore();
  List<RecipeCardBundle> _bundle;
  // ignore: must_call_super

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<List<RecipeCardBundle>>(
      future: _f1.showData(),
      builder: (context, snapshot) {
        return Column(children: <Widget>[
          Categories(),
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 0.1),
            child: GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing:
                      SizeConfig.orientation == Orientation.landscape
                          ? SizeConfig.defaultSize * 2
                          : 0,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RecipeDetailsScreen.screen,
                              arguments: snapshot.data[index]);
                        },
                        child: RecipeCard(
                          r1: snapshot.data[index],
                          screen: RecipeDetailsScreen.screen,
                        ),
                      ),
                    );
                    // ignore: missing_return
                  } else {
                    Text("Loading Data");
                  }
                }),
          ))
        ]);
      },
    ));
  }
}
