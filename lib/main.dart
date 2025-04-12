import 'package:flutter/material.dart';
import 'features/calculator/presentation/calculator_page.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.black, // Orqa fonni qora qilish
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.green, // AppBar fonini yashil qilish
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green, // Tugmalarni yashil qilish
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white), // Matnni oq qilish
        bodyMedium: TextStyle(color: Colors.white), // Matnni oq qilish
      ),
    ),
  ));
}
