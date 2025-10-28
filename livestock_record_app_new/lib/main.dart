import 'package:flutter/material.dart';
import 'splash_page.dart'; // make sure this matches the location of your file

void main() {
  runApp(const PetnestApp());
}

class PetnestApp extends StatelessWidget {
  const PetnestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Petnest',
      home: const SplashPage(),
    );
  }
}
