import 'dart:io';
import 'package:flutter/material.dart';
import 'screens/motel_screen.dart'; // Tela principal
import 'utils/http_override.dart'; // Importando nosso Override SSL

void main() {
  HttpOverrides.global = MyHttpOverrides(); // Ignora erros de SSL
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motel List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MotelScreen(),
    );
  }
}
