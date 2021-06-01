import 'package:easy_cook/provider/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_cook/constants.dart';
import 'package:easy_cook/data/RecipeCardBundle.dart';
import 'package:easy_cook/pages/home/home_screen.dart';
import 'package:easy_cook/size_config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static String screen = "RecipeDetailsScreen";
  final double size = SizeConfig.defaultSize;
  bool admin = false;
  RecipeDetailsScreen({admin});
  @override
  Widget build(BuildContext context) {
    RecipeCardBundle r1 = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        floatingActionButton: admin
            ? FloatingActionButton(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                backgroundColor: Colors.white,
              )
            : Text('null'),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              buildSliverAppBar(r1, context),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: size * 1,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: size * 1.8, right: 70),
                            child: Text(
                              r1.titleOfRecipe,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  fontFamily: 'Pacifico'),
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size * 3,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size * 1,
                          ),
                          Icon(
                            Icons.play_arrow,
                            size: size * 2.5,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: " Play", style: TextStyle(fontSize: 15)),
                            TextSpan(
                                text: "\nVideo",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ])),
                          Container(
                            height: size * 4,
                            width: 1.5,
                            margin: EdgeInsets.symmetric(horizontal: size * 4),
                            color: Colors.black,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Food", style: TextStyle(fontSize: 15)),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: r1.place,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ])),
                          Container(
                            height: size * 4,
                            width: 1.5,
                            margin: EdgeInsets.symmetric(horizontal: size * 4),
                            color: Colors.black,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Time Cooking",
                                style: TextStyle(fontSize: 15)),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: r1.time,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]))
                        ],
                      ),
                      SizedBox(
                        height: size * 3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size * 1),
                        child: Text(
                          "Ingredients: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: size * 1.2),
                      Padding(
                        padding: EdgeInsets.only(left: size * 1),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              r1.ingredient,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontFamily: 'Caveat', fontSize: 27),
                            )),
                      ),
                      SizedBox(
                        height: size * 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size * 1),
                        child: Text(
                          "How To Cook It ? ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: size * 1,
                      ),
                      Expanded(
                          child: Padding(
                        padding:
                            EdgeInsets.only(left: size * 1, right: size * 1),
                        child: Text(
                          r1.howToCookIt,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'Caveat'),
                        ),
                      )),
                      // YoutubePlayer(controller: _controller),
                    ],
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0)),
                      color: Colors.green),
                  height: 1000,
                ),
              ]))
            ],
          ),
        ));
  }

  SliverAppBar buildSliverAppBar(RecipeCardBundle r1, BuildContext context) {
    return SliverAppBar(
      leading: Padding(
        padding: EdgeInsets.all(size * 0.8),
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.screen);
          },
          color: kPrimaryColor,
          textColor: Colors.white,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back_ios,
              size: size * 1.2,
            ),
          ),
          shape: CircleBorder(),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.4,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: FittedBox(
          child: Image.network(r1.thumbnailUrl),
          fit: BoxFit.fill,
        ),
      )),
    );
  }
}
