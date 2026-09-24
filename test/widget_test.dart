import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employee_management_application/main.dart';
import 'package:employee_management_application/view/splash_screen.dart';
import 'package:employee_management_application/view/login_screen.dart';
import 'package:employee_management_application/view/bottom_nav_bar.dart';
import 'package:employee_management_application/controller/auth_controller.dart';
import 'package:employee_management_application/model/user_model.dart';

void main() {
  testWidgets('SplashScreen displays three people emoji and title', (WidgetTester tester) async {
    await tester.pumpWidget(const EmployeeManagementApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('👥'), findsOneWidget);
    expect(find.text('👨‍💼 👩‍💼 🧑‍💼'), findsOneWidget);
    expect(find.text('Employee Manager'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });

  testWidgets('LoginScreen displays form, three people emoji, forgot password, and action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const EmployeeManagementApp());

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('👥'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text('NEW USER? REGISTER HERE'), findsOneWidget);
  });

  testWidgets('BottomNavBarScreen displays EMS Home, Search, Task, Profile and shows Employee Management UI', (WidgetTester tester) async {
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

    // Verify all 4 tabs exist in bottom navigation bar
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Task'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Initial tab is Employee Management System (Home)
    expect(find.text('Employee Management System'), findsOneWidget);
    expect(find.text('Search Employee by ID'), findsOneWidget);
    expect(find.text('Add Employee'), findsOneWidget);

    // Verify sample employees rendered on EMS screen
    expect(find.text('Rahul Sharma'), findsOneWidget);
    expect(find.text('rahul.sharma@ems.com'), findsOneWidget);

    // Tap on Search tab
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(find.text('Search Directory'), findsOneWidget);

    // Tap on Task tab
    await tester.tap(find.text('Task'));
    await tester.pumpAndSettle();
    expect(find.text('My Tasks'), findsOneWidget);

    // Tap on Profile tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify Profile shows logged in person details
    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Rohan Sharma'), findsOneWidget);
    expect(find.text('EMP-777'), findsOneWidget);
    expect(find.text('rohan@ems.com'), findsOneWidget);
    expect(find.text('9876543210'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);
    expect(find.text('Software Developer'), findsWidgets);
    expect(find.text('50,000 / month'), findsOneWidget);
    expect(find.text('Pune, Maharashtra'), findsOneWidget);
  });
}
