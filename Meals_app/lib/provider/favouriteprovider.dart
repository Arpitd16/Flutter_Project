//import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/models/meal.dart';

class Favouritenotifier extends StateNotifier<List<Meal>> {
  Favouritenotifier() : super([]);

  bool togglemealfavourite(Meal meal) {
    final mealisfavourite = state.contains(meal);
    if (mealisfavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true; //... spreade opertator aff all the element by separate by comma
    }
  }
}

final favouriteprovider =
    StateNotifierProvider<Favouritenotifier, List<Meal>>((ref) {
  return Favouritenotifier();
});
