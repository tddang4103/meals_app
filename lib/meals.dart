import 'package:flutter/material.dart';
import 'package:meals_app/meal_detail.dart';
import 'package:meals_app/meal_item.dart';
import 'package:meals_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onSelectedFavories,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onSelectedFavories;

  void _onSelected(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealDetailScreen(
              meal: meal,
              onSelectedFavories: onSelectedFavories,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh...nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a differrent category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
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
              onSelectedMeal: () {
                _onSelected(ctx, meals[index]);
              },
            ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }
}
