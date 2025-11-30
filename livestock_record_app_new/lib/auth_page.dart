import 'package:flutter/material.dart';
import 'pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        // ---------------------------
        // BLACK & GREY GRADIENT BACKGROUND
        // ---------------------------
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F0F0F),
              Color(0xFF1A1A1A),
              Color(0xFF0D0D0D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ));

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: showLogin ? _buildLogin(context) : _buildSignup(context),
        ),
      ),
    );
  }

  // ---------------------------
  // LOGIN UI
  // ---------------------------

  Widget _buildLogin(BuildContext context) {
    return Center(
      key: const ValueKey('login'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back 🐾',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              _buildTextField(Icons.email, 'Email'),
              const SizedBox(height: 20),

              _buildTextField(Icons.lock, 'Password', isPassword: true),
              const SizedBox(height: 30),

              _primaryButton('Login', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () => setState(() => showLogin = false),
                child: const Text(
                  "Don’t have an account? Sign Up",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // SIGNUP UI
  // ---------------------------

  Widget _buildSignup(BuildContext context) {
    return Center(
      key: const ValueKey('signup'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Account 🐶',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              _buildTextField(Icons.person, 'Full Name'),
              const SizedBox(height: 20),

              _buildTextField(Icons.email, 'Email'),
              const SizedBox(height: 20),

              _buildTextField(Icons.lock, 'Password', isPassword: true),
              const SizedBox(height: 30),

              _primaryButton('Sign Up', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () => setState(() => showLogin = true),
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // TEXT FIELD (Black theme)
  // ---------------------------

  Widget _buildTextField(IconData icon, String hint, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade800),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.grey.shade300),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  // ---------------------------
  // BUTTON (Black → Grey glow)
  // ---------------------------

  Widget _primaryButton(String text, VoidCallback onPress) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 8,
        shadowColor: Colors.black,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
