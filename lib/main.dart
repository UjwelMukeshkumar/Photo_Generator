import 'package:flutter/material.dart';
import 'package:generator/Controller/home_controller.dart';
import 'package:generator/view/home/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => HomeProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Homescreen()),
    );
  }
}
