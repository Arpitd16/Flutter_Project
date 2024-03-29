import 'package:chatapp/screens/auth.dart';
import 'package:chatapp/screens/chat.dart';
import 'package:chatapp/screens/slashchat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
//   options: const FirebaseOptions(
//   apiKey: "AIzaSyD1F4k7pYd7RF-6tLIWBNiMPgtS8ogDScc",
//   appId: "1:269208703301:android:54a55f0d7ce084ff5b6e2c",
//   messagingSenderId: "messaging id",
//   projectId: "flutter-chat-app-55271",
// ),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Slashchat();
          }
          if (snapshot.hasData) {
            return const Chatscreen();
          }
          return const Authscreen();
        },
      ),
    );
  }
}
