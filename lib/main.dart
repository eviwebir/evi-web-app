import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() => runApp(EviWebApp());

class EviWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}
