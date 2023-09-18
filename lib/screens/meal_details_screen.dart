import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends ConsumerWidget {
  MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? 'Meal added  as favourite'
                        : 'Meal removed from favourites',
                  ),
                ),
              );
            },
            icon: isFavorite
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 10.0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 300.0,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "Ingredients",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15.0),
                  for (final ingredient in meal.ingredients)
                    Text(
                      textAlign: TextAlign.start,
                      ingredient,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  const SizedBox(height: 15.0),
                  Text(
                    textAlign: TextAlign.start,
                    "Steps",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15.0),
                  for (final step in meal.steps)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        step,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                ],
              ),
            ),
            // Container(
            //   height: 500.0,
            //   width: double.infinity,
            //   color: Colors.red,
            // )
          ],
        ),
      ),
    );
  }
}
