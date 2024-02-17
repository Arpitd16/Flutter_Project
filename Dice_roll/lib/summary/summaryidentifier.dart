import 'package:flutter/material.dart';

class Summaryidentifier extends StatelessWidget {

  const Summaryidentifier({
    super.key,
    required this.iscorrectans,
    required this.questionindex,
  });

  final bool iscorrectans;

  final int questionindex;

  @override
  Widget build(BuildContext context) {
    final questionnumber = questionindex + 1;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: iscorrectans?
        const Color.fromARGB(255,140, 190, 255)
        :const Color.fromARGB(255, 249, 130, 256),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        questionnumber.toString(),
        style: const TextStyle(
          color: Color.fromARGB(255, 20, 10, 60),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
