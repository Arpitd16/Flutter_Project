import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adv_basics/summary/summaryidentifier.dart';

class Summaryitem extends StatelessWidget {
  const Summaryitem(this.itemdata, {super.key});

  final Map<String, Object> itemdata;

  @override
  Widget build(BuildContext context) {
    final iscorrectans =
        itemdata['correct_answer'] == itemdata['selected_answer'];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Summaryidentifier(
            iscorrectans: iscorrectans,
            questionindex: itemdata['question_index'] as int,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemdata['question'] as String,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  itemdata['selected_answer'] as String,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 202, 171, 255),
                  ),
                ),
                Text(
                  itemdata['correct_answer'] as String,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 101, 254, 246),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
