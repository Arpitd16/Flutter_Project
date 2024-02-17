import 'package:flutter/material.dart';
import 'package:adv_basics/summary/summaryiteam.dart';

class Questionsummary extends StatelessWidget {
  const Questionsummary(this.summarydata, {super.key});

  final List<Map<String, Object>> summarydata;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summarydata.map((data) {
            return Summaryitem(data);
          }).toList(),
        ),
      ),
    );
  }
}
