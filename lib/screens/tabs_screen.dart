import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals_app/providers/favorites_provider.dart";
import "package:meals_app/providers/filters_provider.dart";
import "package:meals_app/screens/categories_screen.dart";
import 'package:meals_app/screens/filters_screen.dart';
import "package:meals_app/screens/meals_screen.dart";
import "package:meals_app/widgets/main_drawer.dart";

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
// ConsumerState is used bcuz
// we want to gain acces or use a provider
  const TabsScreen({
    super.key,
  });

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ref is a property that listens for functiomns or updates in the app
    // and it is provided by the flutter_riverpod package

    // final meals = ref.read(mealsProvider); // ref.read() function is a property
    //that listens and reads information provided from the provider file only once

    final meals = ref.watch(filteredMealProvider);
    // ref.watch() function is just like
    // the ref.read() function but forces the build finction to run everytime
    // the information in the provider file changes

    var activePageTitle = "Categories";
    Widget activePage = CategoriesScreen(
      availableMeals: ref.watch(filteredMealProvider),
    );
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePageTitle = "Your Favorites";
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _selectScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
          )
        ],
      ),
    );
  }
}
