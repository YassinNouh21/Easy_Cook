import 'dart:ffi';

import 'package:easy_cook/pages/loginpage/SignUp.dart';

class RecipeCardBundle {
  String titleOfRecipe;
  String rating;
  String place;
  String thumbnailUrl;
  String ingredient;
  String howToCookIt;
  String time;
  RecipeCardBundle({
    this.ingredient,
    this.howToCookIt,
    this.titleOfRecipe,
    this.place,
    this.rating,
    this.thumbnailUrl,
    this.time,
  });
}

class module extends RecipeCardBundle {
  List<RecipeCardBundle> module1 = [];
}
