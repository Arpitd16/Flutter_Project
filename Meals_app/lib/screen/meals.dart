import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/widget/mealitem.dart';
import 'package:mealapp/screen/mealdetails.dart';

class Mealscreen extends StatelessWidget {
  const Mealscreen({
    super.key,
    this.title,
    required this.meals,
    //required this.ontogglemeal,
  });
  final String? title;
  final List<Meal> meals;
  //final void Function(Meal meal) ontogglemeal;

  void selectmeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Mealdetailscreen(
          meal: meal,
          //ontogglemeal: ontogglemeal,
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
            "oh! no .... nothing here",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'try selecting a diffrent catagory!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Mealitem(
          meal: meals[index],
          onselectmeal: (meal) {
            selectmeal(context, meal);
          },
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
