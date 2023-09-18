import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavotiteMealsNotifier extends StateNotifier<List<Meal>> {
  FavotiteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
      // the spread operator (...) is used on a list to pull out
      // all the elements stored in the main list, for example FavotiteMealsNotifier list
      // and add them as individual elements to the new list, for example this list above i.e state
    }
  }
}
// creating my my own class that extends the properties of the SateNotifier class
// adding the :super() to reach out to the content of the parent class, that is StateNotifier class

final favoriteMealsProvider =
    StateNotifierProvider<FavotiteMealsNotifier, List<Meal>>(
  (ref) => FavotiteMealsNotifier(),
);
