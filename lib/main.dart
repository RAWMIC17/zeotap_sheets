import 'package:flutter/material.dart';
import 'package:zeotap_sheets_1/screens/spreadsheetScreen.dart';
import 'package:zeotap_sheets_1/utils/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: MyRoutes.homeRoute,
      routes: {
         "/": (context) =>Spreadsheetscreen(),
         MyRoutes.homeRoute: (context) => Spreadsheetscreen(),
      },
    );
  }
}
