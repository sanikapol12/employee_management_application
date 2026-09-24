
// ========================================================

import 'package:flutter/material.dart';
import '../model/user_model.dart';

class AuthController extends ChangeNotifier {
  // Storing currently logged in employee
  UserModel? currentUser;
  bool isLoading = false;
  String errorMessage = '';

  // Dynamic list of registered users (no hardcoded demo users)
  List<UserModel> registeredUsers = [];
  Map<String, String> userPasswords = {};

  // Login function
  Future<bool> login(String email, String password) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();

    // Small delay for button loading
    await Future.delayed(const Duration(seconds: 1));

    // Check if user is registered in the list
    UserModel? found;
    for (var u in registeredUsers) {
      if (u.email.trim().toLowerCase() == email.trim().toLowerCase()) {
        found = u;
        break;
      }
    }

    if (found != null) {
      if (userPasswords[found.email.toLowerCase()] == password) {
        currentUser = found;
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = 'Wrong password entered!';
        isLoading = false;
        notifyListeners();
        return false;
      }
    } else {
      // If list is empty or user is logging in directly, create user profile from login input
      if (password.length >= 6) {
        currentUser = UserModel(
          empId: 'EMP-${email.split('@')[0].toUpperCase()}',
          name: email.split('@')[0],
          email: email.trim(),
          phone: 'Not provided',
          department: 'General Staff',
          designation: 'Employee',
          salary: 'Not specified',
          joiningDate: 'Today',
          address: 'Office Location',
          imageUrl: '',
        );
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = 'Password must be at least 6 characters.';
        isLoading = false;
        notifyListeners();
        return false;
      }
    }
  }

  // Register new employee with all basic details filled by user
  Future<bool> registerEmployee(UserModel newEmployee, String password) async {
    errorMessage = '';
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    // Save employee in list
    registeredUsers.add(newEmployee);
    userPasswords[newEmployee.email.toLowerCase()] = password;
    currentUser = newEmployee;

    isLoading = false;
    notifyListeners();
    return true;
  }

  // Google sign in button handler
  Future<bool> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    // Simple profile for Google sign-in
    currentUser = UserModel(
      empId: 'EMP-A101',
      name: 'Google User',
      email: 'user.google@gmail.com',
      phone: '+91 9876543210',
      department: 'Technology',
      designation: 'Software Trainee',
      salary: '35,000 / month',
      joiningDate: '25/09/2026',
      address: 'City Office Campus',
      imageUrl: '',
    );

    isLoading = false;
    notifyListeners();
    return true;
  }

  // Logout method
  void logout() {
    currentUser = null;
    errorMessage = '';
    notifyListeners();
  }
}
