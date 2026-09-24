

import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Simple text controllers (no demo credentials prefilled)
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Auth controller object
  final AuthController authController = AuthController();

  // Simple password show hide variable
  bool hidePassword = true;

  // Login function
  void doLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password!')),
      );
      return;
    }

    bool ok = await authController.login(email, password);

    if (ok && mounted) {
      // Go to main navigation with dashboard and bottom bar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(authController: authController),
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authController.errorMessage)),
      );
    }
  }

  // Google sign in function
  void doGoogleSignIn() async {
    bool ok = await authController.signInWithGoogle();
    if (ok && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBarScreen(authController: authController),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Login'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Three People Emoji
                const Center(
                  child: Text('👥', style: TextStyle(fontSize: 55)),
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text('👨‍💼 👩‍💼 🧑‍💼', style: TextStyle(fontSize: 22)),
                ),
                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    'Employee Portal',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Center(
                  child: Text(
                    'Sign in with your employee account',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 25),

                // Email field
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // Password field
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),

                // Forgot Password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                  ),
                ),

                const SizedBox(height: 10),

                // 2. Login Button
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      doLogin();
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 3. New User Button
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                    ),
                    onPressed: () {
                      // Navigate to Register Screen to get all employee details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(authController: authController),
                        ),
                      );
                    },
                    child: const Text(
                      'NEW USER? REGISTER HERE',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Simple Divider
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('OR', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),

                // 4. Google Sign In Button
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      doGoogleSignIn();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('G', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
