import 'package:flutter/material.dart';
import 'package:mealapp/models/catagory.dart';

class Catagoryitem extends StatelessWidget {
  const Catagoryitem({
    super.key,
    required this.catagory,
    required this.onselectcatagory,
  });

  final Catagory catagory;
  final void Function() onselectcatagory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onselectcatagory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              catagory.color.withOpacity(0.45),
              catagory.color.withOpacity(0.60),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          catagory.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
