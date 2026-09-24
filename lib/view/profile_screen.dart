

import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AuthController authController;

  const ProfileScreen({super.key, required this.authController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Simple logout function
  void doLogout() {
    widget.authController.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Logged in person data from controller
    final emp = widget.authController.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // hide back button inside bottom nav
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              doLogout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 1. Employee Profile Image
              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 75,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 2. Employee Name
              Center(
                child: Text(
                  emp != null && emp.name.isNotEmpty ? emp.name : 'Unknown Employee',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Designation under name
              Center(
                child: Text(
                  emp != null && emp.designation.isNotEmpty ? emp.designation : 'Staff',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 15),
              const Divider(thickness: 1),
              const SizedBox(height: 10),

              // 3. All Basic Details of Logged-In Person
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Employee Basic Details:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Employee ID
              Card(
                child: ListTile(
                  leading: const Icon(Icons.badge, color: Colors.blue),
                  title: const Text('Employee ID', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.empId.isNotEmpty == true ? emp!.empId : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Email
              Card(
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: const Text('Email Address', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.email.isNotEmpty == true ? emp!.email : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Phone
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone, color: Colors.blue),
                  title: const Text('Phone Number', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.phone.isNotEmpty == true ? emp!.phone : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Department
              Card(
                child: ListTile(
                  leading: const Icon(Icons.domain, color: Colors.blue),
                  title: const Text('Department', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.department.isNotEmpty == true ? emp!.department : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Designation
              Card(
                child: ListTile(
                  leading: const Icon(Icons.work, color: Colors.blue),
                  title: const Text('Designation / Role', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.designation.isNotEmpty == true ? emp!.designation : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Salary
              Card(
                child: ListTile(
                  leading: const Icon(Icons.attach_money, color: Colors.blue),
                  title: const Text('Salary / Package', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.salary.isNotEmpty == true ? emp!.salary : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Date of Joining
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text('Date of Joining', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.joiningDate.isNotEmpty == true ? emp!.joiningDate : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              // Address
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.blue),
                  title: const Text('Address / City', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  subtitle: Text(
                    emp?.address.isNotEmpty == true ? emp!.address : 'N/A',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    doLogout();
                  },
                  child: const Text('LOGOUT', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
