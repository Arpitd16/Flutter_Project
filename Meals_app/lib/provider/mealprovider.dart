import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/data/dummiesdata.dart';

final mealsprovider = Provider((ref) {
  return dummyMeals;
});
