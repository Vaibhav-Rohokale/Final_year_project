import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'auth_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 👇 Initialize animation immediately
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // 👇 Navigate to AuthPage after animation finishes
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 52.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: Colors.deepPurple,
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.purpleAccent,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText('Petnest 🐾',
                    duration: const Duration(milliseconds: 1800)),
              ],
              isRepeatingAnimation: false,
            ),
          ),
        ),
      ),
    );
  }
}
