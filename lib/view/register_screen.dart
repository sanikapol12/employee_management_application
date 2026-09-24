import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import '../model/user_model.dart';
import 'bottom_nav_bar.dart';

class RegisterScreen extends StatefulWidget {
  final AuthController authController;

  const RegisterScreen({super.key, required this.authController});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for all basic details of employee
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Simple register function
  void doRegister() async {
    // Basic checking
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill Name, Email, and Password!')),
      );
      return;
    }

    // Creating model object with user input values
    UserModel emp = UserModel(
      empId: empIdController.text.isNotEmpty ? empIdController.text : 'EMP-01',
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text.isNotEmpty ? phoneController.text : 'N/A',
      department: departmentController.text.isNotEmpty
          ? departmentController.text
          : 'General',
      designation: designationController.text.isNotEmpty
          ? designationController.text
          : 'Staff',
      salary: salaryController.text.isNotEmpty ? salaryController.text : 'N/A',
      joiningDate: joiningDateController.text.isNotEmpty
          ? joiningDateController.text
          : 'Today',
      address: addressController.text.isNotEmpty
          ? addressController.text
          : 'N/A',
    );

    // Call controller
    bool result = await widget.authController.registerEmployee(
      emp,
      passwordController.text,
    );

    if (result && mounted) {
      // Go directly to bottom navigation with dashboard and profile
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BottomNavBarScreen(authController: widget.authController),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Employee Registration'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Three people emoji
              const Center(child: Text('👥', style: TextStyle(fontSize: 40))),
              const Center(child: Text('', style: TextStyle(fontSize: 16))),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Enter All Employee Basic Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),

              // 1. Employee ID
              TextField(
                controller: empIdController,
                decoration: const InputDecoration(
                  labelText: 'Employee ID',
                  hintText: 'e.g. EMP-101',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 2. Full Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'e.g. mark zuckerburg',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 3. Email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'e.g. mark@company.com',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 4. Phone
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'e.g. 9876543210',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 5. Department
              TextField(
                controller: departmentController,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  hintText: 'e.g. IT, HR, Sales, Finance',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 6. Designation
              TextField(
                controller: designationController,
                decoration: const InputDecoration(
                  labelText: 'Designation / Role',
                  hintText: 'e.g. Software Engineer, Assistant',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 7. Salary
              TextField(
                controller: salaryController,
                decoration: const InputDecoration(
                  labelText: 'Salary / Package',
                  hintText: 'e.g. 40,000 / month',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 8. Date of Joining
              TextField(
                controller: joiningDateController,
                decoration: const InputDecoration(
                  labelText: 'Joining Date',
                  hintText: 'e.g. 15-Jan-2026',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 9. Address
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'e.g. Pune, Maharashtra',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // 10. Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Submit button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    doRegister();
                  },
                  child: const Text(
                    'SUBMIT & VIEW ON HOMEPAGE',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
