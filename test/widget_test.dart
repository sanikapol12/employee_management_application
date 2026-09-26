import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employee_management_application/main.dart';
import 'package:employee_management_application/view/splash_screen.dart';
import 'package:employee_management_application/view/login_screen.dart';
import 'package:employee_management_application/view/register_screen.dart';
import 'package:employee_management_application/view/bottom_nav_bar.dart';
import 'package:employee_management_application/view/theme_screen.dart';
import 'package:employee_management_application/view/widgets/google_sign_in_button.dart';
import 'package:employee_management_application/controller/auth_controller.dart';
import 'package:employee_management_application/controller/theme_controller.dart';
import 'package:employee_management_application/model/user_model.dart';

void main() {
  testWidgets('SplashScreen displays enterprise corporate badge and no emojis', (WidgetTester tester) async {
    await tester.pumpWidget(const EmployeeManagementApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('👥'), findsNothing);
    expect(find.text('👨‍💼 👩‍💼 🧑‍💼'), findsNothing);
    expect(find.text('EMPLOYEE MANAGER'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('LoginScreen displays modern UI, Google Sign In, and TextButton registration', (WidgetTester tester) async {
    await tester.pumpWidget(const EmployeeManagementApp());

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('👥'), findsNothing);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Work Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('SIGN IN'), findsOneWidget);
    expect(find.text('NEW USER? REGISTER HERE'), findsNothing);
    expect(find.text('Register here'), findsOneWidget);
    expect(find.text('New user? '), findsOneWidget);
    expect(find.byType(GoogleSignInButton), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
  });

  testWidgets('Home page displays EMS metrics (Total, Present, Absent, Late, On Leave) instead of search bar', (WidgetTester tester) async {
    final controller = AuthController();
    controller.currentUser = UserModel(
      empId: 'EMP-777',
      name: 'Rohan Sharma',
      email: 'rohan@ems.com',
      phone: '9876543210',
      department: 'Technology',
      designation: 'Software Developer',
      salary: '50,000 / month',
      joiningDate: '01/01/2026',
      address: 'Pune, Maharashtra',
    );

    await tester.pumpWidget(MaterialApp(
      home: BottomNavBarScreen(authController: controller),
    ));

    // Search bar is removed from Home page
    expect(find.text('Search Employee by ID'), findsNothing);

    // EMS metrics are displayed
    expect(find.text('TOTAL EMPLOYEES'), findsOneWidget);
    expect(find.text('PRESENT'), findsOneWidget);
    expect(find.text('ABSENT'), findsOneWidget);
    expect(find.text('LATE'), findsOneWidget);
    expect(find.text('ON LEAVE'), findsOneWidget);

    // Employee directory list
    expect(find.text('Rahul Sharma'), findsOneWidget);
    expect(find.text('Add Employee'), findsOneWidget);
  });

  testWidgets('Task page has bottom plus button that opens card with textfield and ADD button', (WidgetTester tester) async {
    final controller = AuthController();
    await tester.pumpWidget(MaterialApp(
      home: BottomNavBarScreen(authController: controller),
    ));

    // Navigate to Task tab
    await tester.tap(find.text('Task'));
    await tester.pumpAndSettle();

    expect(find.text('MY TASKS'), findsOneWidget);

    // Top add task row should not exist (hintText 'Enter new task...' removed)
    expect(find.text('Enter new task...'), findsNothing);

    // Bottom plus button exists
    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);

    // Tap the plus button to open card
    await tester.tap(fabFinder);
    await tester.pumpAndSettle();

    // Verify card appears with textfield to enter task and button named ADD
    expect(find.text('Add New Task'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'ADD'), findsOneWidget);

    // Enter a new task description and tap ADD
    await tester.enterText(find.widgetWithText(TextField, ''), 'Prepare sprint review presentation');
    await tester.tap(find.widgetWithText(ElevatedButton, 'ADD'));
    await tester.pumpAndSettle();

    // Verify task is added to list and card closed
    expect(find.text('Prepare sprint review presentation'), findsOneWidget);
  });

  testWidgets('Profile page removes SETTINGS & PREFERENCES button and uses AppBar settings for drawer', (WidgetTester tester) async {
    final controller = AuthController();
    controller.currentUser = UserModel(
      empId: 'EMP-777',
      name: 'Rohan Sharma',
      email: 'rohan@ems.com',
      phone: '9876543210',
      department: 'Technology',
      designation: 'Software Developer',
      salary: '50,000 / month',
      joiningDate: '01/01/2026',
      address: 'Pune, Maharashtra',
    );

    await tester.pumpWidget(MaterialApp(
      home: BottomNavBarScreen(authController: controller),
    ));

    // Navigate to Profile tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify old direct logout button is removed from body
    expect(find.widgetWithText(ElevatedButton, 'LOGOUT'), findsNothing);

    // Verify SETTINGS & PREFERENCES button is removed from profile page
    expect(find.text('SETTINGS & PREFERENCES'), findsNothing);

    // Settings button exists in AppBar
    final settingsBtn = find.byTooltip('Settings');
    expect(settingsBtn, findsOneWidget);

    // Tap Settings button to open drawer
    await tester.tap(settingsBtn);
    await tester.pumpAndSettle();

    // Drawer should be open and contain: Profile, Theme, Departments, Designations & Roles, Logout
    expect(find.text('Profile'), findsWidgets);
    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('Departments'), findsOneWidget);
    expect(find.text('Designations & Roles'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('RegisterScreen requires profile pic and validates mandatory fields', (WidgetTester tester) async {
    final controller = AuthController();

    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(authController: controller),
    ));

    // Profile photo button is present (optional)
    expect(find.text('Select Profile Photo (Optional)'), findsOneWidget);

    // All fields have mandatory '*' marker
    expect(find.text('Employee ID *'), findsOneWidget);
    expect(find.text('Full Name *'), findsOneWidget);
    expect(find.text('Work Email *'), findsOneWidget);
    expect(find.text('Phone Number *'), findsOneWidget);
    expect(find.text('Department *'), findsOneWidget);
    expect(find.text('Designation / Role *'), findsOneWidget);
    expect(find.text('Salary *'), findsOneWidget);
    expect(find.text('Joining Date *'), findsOneWidget);
    expect(find.text('Office / City Address *'), findsOneWidget);
    expect(find.text('Account Password *'), findsOneWidget);

    // Ensure submit button is visible and tap it
    final submitBtn = find.widgetWithText(ElevatedButton, 'SUBMIT REGISTRATION');
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    // Verify mandatory validations fire (photo is optional)
    expect(find.text('Employee ID is mandatory'), findsOneWidget);
    expect(find.text('Full Name is mandatory'), findsOneWidget);
    expect(find.text('Email Address is mandatory'), findsOneWidget);
    expect(find.text('Phone Number is mandatory'), findsOneWidget);
  });

  testWidgets('ThemeScreen toggles dark to light and light to dark', (WidgetTester tester) async {
    final themeController = ThemeController.instance;
    themeController.setThemeMode(ThemeMode.light);

    await tester.pumpWidget(
      ListenableBuilder(
        listenable: themeController,
        builder: (context, _) => MaterialApp(
          themeMode: themeController.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const ThemeScreen(),
        ),
      ),
    );

    expect(find.text('THEME & APPEARANCE'), findsOneWidget);
    expect(find.text('Light Mode (Dark to Light)'), findsOneWidget);
    expect(find.text('Dark Mode (Light to Dark)'), findsOneWidget);
    expect(find.text('Light Mode Active'), findsOneWidget);

    // Tap on Dark Mode card
    await tester.tap(find.text('Dark Mode (Light to Dark)'));
    await tester.pumpAndSettle();

    // Should switch to Dark Mode Active
    expect(themeController.isDarkMode, isTrue);
    expect(find.text('Dark Mode Active'), findsOneWidget);

    // Tap on Light Mode card
    await tester.tap(find.text('Light Mode (Dark to Light)'));
    await tester.pumpAndSettle();

    // Should switch back to Light Mode
    expect(themeController.isDarkMode, isFalse);
    expect(find.text('Light Mode Active'), findsOneWidget);
  });

  testWidgets('LoginScreen form validation triggers on empty and invalid inputs', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // Tap SIGN IN without filling anything
    final signInBtn = find.widgetWithText(ElevatedButton, 'SIGN IN');
    expect(signInBtn, findsOneWidget);
    await tester.tap(signInBtn);
    await tester.pumpAndSettle();

    // Verify form validation error messages
    expect(find.text('Work Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);

    // Enter invalid email format and short password
    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;

    await tester.enterText(emailField, 'invalidemail');
    await tester.enterText(passwordField, '123');
    await tester.tap(signInBtn);
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid email address (e.g. name@company.com)'), findsOneWidget);
    expect(find.text('Password must be more than 8 characters'), findsOneWidget);
  });

  testWidgets('RegisterScreen form includes Country API synced field and mandatory validation', (WidgetTester tester) async {
    final controller = AuthController();
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(authController: controller),
    ));

    expect(find.text('Country *'), findsOneWidget);

    final submitBtn = find.widgetWithText(ElevatedButton, 'SUBMIT REGISTRATION');
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    expect(find.text('Country is mandatory'), findsOneWidget);
  });
}
