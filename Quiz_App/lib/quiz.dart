import 'package:flutter/material.dart';
import 'package:adv_basics/startscreen.dart';
import 'package:adv_basics/questionpage.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/resultscreen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
   List<String> selectedanswer = [];
  var activescreen = 'start-screen';

  //  @override
  // void initState() {
  //   activescreen= Startscreen(switchScreen);
  //    todo: implement initState
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      activescreen = 'question-screen';
    });
  }
  
  void chooseanswer(String answer){
    selectedanswer.add(answer);

    if(selectedanswer.length==questions.length){
      setState(() {
        activescreen='result-screen';
      });
    }
  }
  void restartquiz(){
    setState(() {
      selectedanswer=[];
      activescreen='question-screen';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = Startscreen(switchScreen);

    if (activescreen == 'question-screen') {
      screenWidget = Question(onselectanswer: chooseanswer,);
    }
    
    if(activescreen=='result-screen'){
      screenWidget=ResultScreen(chooseanwer: selectedanswer,onrestartquiz: restartquiz,);
    }


    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 21, 6, 238),
                  Color.fromARGB(255, 128, 83, 185),
                ],
              ),
            ),
            child: screenWidget
            //trnary operation
            // activescreen == 'start-screen'
            //     ? Startscreen(switchScreen)
            //     : const Question(),,
            ),
      ),
    );
  }
}
