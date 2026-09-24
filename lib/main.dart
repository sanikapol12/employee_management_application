
import 'package:flutter/material.dart';
import 'view/splash_screen.dart';

void main() {
  // Ensure Flutter engine bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EmployeeManagementApp());
}

class EmployeeManagementApp extends StatelessWidget {
  const EmployeeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.indigo.shade600,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      // Starts with Splash Screen, which automatically navigates to Login
      home: const SplashScreen(),
    );
  }
}
