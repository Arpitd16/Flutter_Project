import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/summary/questionsummary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.chooseanwer,required this.onrestartquiz});

  final void Function() onrestartquiz;

  final List<String> chooseanwer;

  List<Map<String, Object>> getSummarydata() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chooseanwer.length; i++) {
      summary.add(
        {
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'selected_answer': chooseanwer[i],
      }
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summarydata = getSummarydata();
    final numtotalque = questions.length;
    final numofcorrect = summarydata.where((data) {
      return data['correct_answer'] == data['selected_answer'];
    }).length;//insted of
    //final numofcorrect = summarydata.where((data) =>
    //    data['correct_answer'] == data['selected_answer']
    // ).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('you answer $numtotalque out of $numofcorrect questions correctly',),
            const SizedBox(
              height: 30,
            ),
            Questionsummary(getSummarydata()),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: onrestartquiz,
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
