import 'package:flutter/material.dart';
import 'package:food_app/model/meal_model.dart';
import 'package:food_app/screens/meal_details_screen.dart';
import 'package:food_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<MealModel> meals;

  void selectMeal(BuildContext context, MealModel meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealDetailsScreen(
              meal: meal,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh...nothing here!',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(
              color:
                  Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(
              color:
                  Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder:
            (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
            ),
      );
    }

    if (title == null) {
      return content;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: content,
      ),
    );
  }
}
