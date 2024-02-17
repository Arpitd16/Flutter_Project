import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/provider/mealprovider.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegetarian,
  vegan,
}

class Filternotifier extends StateNotifier<Map<Filter, bool>> {
  Filternotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  void setfilters(Map<Filter, bool> choosenfilter) {
    state = choosenfilter;
  }

  void setfilter(Filter filter, bool isActive) {
    //state[filter]=isActive;//not allowed!=>mutating state

    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterprovider = StateNotifierProvider<Filternotifier, Map<Filter, bool>>(
  (ref) => Filternotifier(),
);

final filtermealprovider = Provider((ref) {
  final meals = ref.watch(mealsprovider);
  final activefilter = ref.watch(filterprovider);

  return meals.where((meal) {
    if (activefilter[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activefilter[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activefilter[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activefilter[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
