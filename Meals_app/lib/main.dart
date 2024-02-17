import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealapp/screen/tabs.dart';
//import 'package:mealapp/screen/catagories.dart';
// import 'package:mealapp/screen/meals.dart';
// import 'package:mealapp/data/dummiesdata.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Tabscreen(),
      // home:const Catagoryscreen(),
      // home:const Mealscreen(
      //   title:'some catagory...',
      // meals: dummyMeals,
      // )
    );
  }
}
