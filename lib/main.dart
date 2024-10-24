import 'package:flutter/material.dart';
import 'package:my_task_list/pages/homepage/screens/home/home_page.dart';
import "package:hive_flutter/adapters.dart";
import 'package:my_task_list/pages/homepage/screens/instruction/instruction.dart';

void main() async {
  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.blue, // Set the default AppBar color in the theme
        ),
        useMaterial3: true,
      ),
      // home: HomePage(),
      home: InstructionManualPage(),
    );
  }
}
