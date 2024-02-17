class Quizque{
  const Quizque(
    this.text,
    this.answers,
  );
  final String text;
  final List<String> answers;

  List<String> getsuffeledanswers(){
    final sufflelist = List.of(answers);
    sufflelist.shuffle();
    return sufflelist;
  }

}