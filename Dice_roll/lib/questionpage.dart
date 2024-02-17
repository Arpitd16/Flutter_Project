import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adv_basics/answerbutton.dart';
import 'package:adv_basics/data/questions.dart';

class Question extends StatefulWidget {
  const Question({super.key,required this.onselectanswer});

  final void Function(String answer) onselectanswer;

  @override
  State<Question> createState() {
    return _Question();
  }
}

class _Question extends State<Question> {
  
  var currentque = 0;

  void answerque(String selectedanswer) {
    widget.onselectanswer(selectedanswer);
    setState(() {
      currentque++;
    });
  }


  @override
  Widget build(context) {
    final currentquestion = questions[currentque];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentquestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentquestion.getsuffeledanswers().map((answer) {
              return Answerbutton(
                answertext: answer,
                onPressed: (){
                  answerque(answer);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
