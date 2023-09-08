import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});
  final void Function(String identifier) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 50.0,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  "Cooking Up!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Meals",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            leading: Icon(
              Icons.restaurant,
              size: 30.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onTap: () => onSelectScreen("meals"),
          ),
          ListTile(
            title: Text(
              "filters",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            leading: Icon(
              Icons.settings,
              size: 30.0,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onTap: () => onSelectScreen("filters"),
          )
        ],
      ),
    );
  }
}