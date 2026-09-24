import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Navigate to Login Screen automatically after 3 seconds
    // (Typical splash screen delay for apps and college project demos)
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Logo container with Three People Emoji
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Three people emoji requested by user
                      Text(
                        '👥',
                        style: TextStyle(fontSize: 56),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '👨‍💼 👩‍💼 🧑‍💼',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // App Title
                const Text(
                  'Employee Manager',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Color(0xFF1E293B),
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle / Tagline
                Text(
                  'Connect • Collaborate • Manage',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.3,
                  ),
                ),

                const Spacer(),

                // Loading Indicator while waiting to navigate
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade600),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Loading workspace...',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),

                const SizedBox(height: 24),

                // Project credit / human touch
                Text(
                  'Developed with Flutter • MVC Architecture',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
