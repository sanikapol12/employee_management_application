import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_logger.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        selectedItemColor: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E40AF),
        unselectedItemColor: isDark ? Colors.grey.shade500 : const Color(0xFF94A3B8),
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        selectedLabelStyle: GoogleFonts.rajdhani(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          letterSpacing: 0.3,
        ),
        unselectedLabelStyle: GoogleFonts.rajdhani(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        elevation: 10,
        onTap: (index) {
          const tabNames = ['Home', 'Search', 'Task', 'Profile'];
          AppLogger.activity('Switched navigation tab', {'tab': tabNames[index], 'index': index});
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            activeIcon: Icon(Icons.task_alt_rounded),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
