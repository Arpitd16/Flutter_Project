import 'package:flutter/material.dart';
import 'package:expence_tracker/moduls/expence.dart';

class Expenceiteam extends StatelessWidget {
  const Expenceiteam(this.expence, {super.key});

  final Expence expence;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      child: Column(
        children: [
          Text(
            expence.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text('\$${expence.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(catagoryicons[expence.catagory]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expence.formatteddate),
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
