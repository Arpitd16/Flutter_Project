import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:expence_tracker/widgets/expences.dart';

var kcolorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 60, 180),
);
var kdarkcolorscheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 6, 90, 180),
); 

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(//it use for roteted screem for same screen layout
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // ).then((fn) {
    
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kdarkcolorscheme,
          cardTheme: const CardTheme().copyWith(
            color: kdarkcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kdarkcolorscheme.primaryContainer,
              foregroundColor: kdarkcolorscheme.onPrimaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolorscheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorscheme.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kcolorscheme.onSecondaryContainer,
                  fontSize: 14,
                ),
              ),
        ),
        home: const Expences(),
      ),
    );
  // });
}
