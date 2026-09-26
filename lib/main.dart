import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'controller/theme_controller.dart';
import 'view/splash_screen.dart';

void main() async {
  // Ensure Flutter engine bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EmployeeManagementApp());
}

class EmployeeManagementApp extends StatelessWidget {
  const EmployeeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;

    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Employee Management Application',
          debugShowCheckedModeBanner: false,
          themeMode: themeController.themeMode,
          // Light Theme
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E3A8A),
              primary: const Color(0xFF1E40AF),
              surface: Colors.white,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xFFF8FAFC),
            cardColor: Colors.white,
            textTheme: GoogleFonts.rajdhaniTextTheme(ThemeData.light().textTheme),
            fontFamily: GoogleFonts.rajdhani().fontFamily,
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFF1E3A8A),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              titleTextStyle: GoogleFonts.rajdhani(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Dark Theme (Light to Dark / Dark to Light support)
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E3A8A),
              primary: const Color(0xFF3B82F6),
              surface: const Color(0xFF1E293B),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF0F172A),
            cardColor: const Color(0xFF1E293B),
            textTheme: GoogleFonts.rajdhaniTextTheme(ThemeData.dark().textTheme),
            fontFamily: GoogleFonts.rajdhani().fontFamily,
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFF0F172A),
              foregroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              titleTextStyle: GoogleFonts.rajdhani(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Starts with Splash Screen, which automatically navigates to Login
          home: const SplashScreen(),
        );
      },
    );
  }
}
