import 'package:flutter/material.dart';

class Slashchat extends StatelessWidget {
  const Slashchat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterchat'),
      ),
      body: const Center(
        child: Text('Lodding...'),
      ),
    );
  }
}
