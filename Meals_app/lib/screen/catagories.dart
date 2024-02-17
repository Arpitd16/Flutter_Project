import 'package:flutter/material.dart';
import 'package:mealapp/data/dummiesdata.dart';
import 'package:mealapp/widget/catagorygridwidget.dart';
import 'package:mealapp/screen/meals.dart';
import 'package:mealapp/models/catagory.dart';
import 'package:mealapp/models/meal.dart';

class Catagoryscreen extends StatefulWidget {
  const Catagoryscreen({
    super.key,
    // required this.ontogglemeal,
    required this.avaliablemeal,
  });

  //final void Function(Meal meal) ontogglemeal;

  final List<Meal> avaliablemeal;

  @override
  State<Catagoryscreen> createState() => _CatagoryscreenState();
}

class _CatagoryscreenState extends State<Catagoryscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectcatagory(BuildContext context, Catagory catagory) {
    final filteredmeals = widget.avaliablemeal
        .where((meal) => meal.categories.contains(catagory.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (cnt) => Mealscreen(
          title: catagory.title,
          meals: filteredmeals,
          //ontogglemeal: ontogglemeal,
        ),
      ),
    ); //is same as Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final catagory in availableCategories)
            Catagoryitem(
              catagory: catagory,
              onselectcatagory: () {
                _selectcatagory(context, catagory);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
