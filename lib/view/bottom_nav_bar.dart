import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'task_screen.dart';
import 'profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  final AuthController authController;

  const BottomNavBarScreen({super.key, required this.authController});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  // Selected tab index (0 = Home, 1 = Search, 2 = Task, 3 = Profile)
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List of 4 tab screens
    final List<Widget> pages = [
      HomeScreen(authController: widget.authController),
      SearchScreen(authController: widget.authController),
      TaskScreen(authController: widget.authController),
      ProfileScreen(authController: widget.authController),
    ];

    return Scaffold(
      // Display current selected page
      body: pages[_selectedIndex],

      // Bottom Navigation Bar with 4 items: Home, Search, Task, Profile
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
