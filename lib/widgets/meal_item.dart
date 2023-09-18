import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get _complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get _affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 5.0,
      child: InkWell(
        onTap: () => onSelectMeal(meal),
        child: Stack(
          children: [
            Hero(
              // this widget can be used to animate items during
              // navigation and must have the same tag as the widget beign
              // animated from on the other screen
              tag: meal.id,
              child: FadeInImage(
                height: 330.0,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 30.0,
                ),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} mins',
                        ),
                        const SizedBox(width: 15.0),
                        MealItemTrait(
                          icon: Icons.work,
                          label: _complexityText,
                        ),
                        const SizedBox(width: 15.0),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: _affordabilityText,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return InkWell(
    //   child: Card(
    //     child: Container(
    //       height: deviceHeight / 3.5,
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           fit: BoxFit.fill,
    //           image: NetworkImage(
    //             meal.imageUrl,
    //           ),
    //         ),
    //       ),
    //       child: Container(
    //         margin: const EdgeInsets.only(top: 180.0),
    //         padding: const EdgeInsets.all(15.0),
    //         color: const Color.fromARGB(73, 0, 0, 0),
    //         child: Text(
    //           meal.title,
    //           maxLines: 2,
    //           textAlign: TextAlign.center,
    //           softWrap: true,
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(
    //             fontSize: 20.0,
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
