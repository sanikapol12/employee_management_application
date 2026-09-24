import 'package:flutter/material.dart';
import '../model/employee_model.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final EmployeeModel? employee; // null if adding, non-null if editing

  const AddEditEmployeeScreen({super.key, this.employee});

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers for required fields: Name, Email, Mobile, Country, State, District
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController countryController;
  late TextEditingController stateController;
  late TextEditingController districtController;

  @override
  void initState() {
    super.initState();

    // Check if we are in Edit mode or Add mode
    // Pre-populate data if editing!
    final emp = widget.employee;
    idController = TextEditingController(
      text: emp != null ? emp.id : 'EMP-${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
    );
    nameController = TextEditingController(text: emp != null ? emp.name : '');
    emailController = TextEditingController(text: emp != null ? emp.email : '');
    mobileController = TextEditingController(text: emp != null ? emp.mobile : '');
    countryController = TextEditingController(text: emp != null ? emp.country : '');
    stateController = TextEditingController(text: emp != null ? emp.state : '');
    districtController = TextEditingController(text: emp != null ? emp.district : '');
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    countryController.dispose();
    stateController.dispose();
    districtController.dispose();
    super.dispose();
  }

  // Save employee method
  void saveEmployee() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newOrUpdatedEmployee = EmployeeModel(
      id: idController.text.trim(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobile: mobileController.text.trim(),
      country: countryController.text.trim(),
      state: stateController.text.trim(),
      district: districtController.text.trim(),
    );

    // Return the employee object back to the caller
    Navigator.pop(context, newOrUpdatedEmployee);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employee != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Employee' : 'Add New Employee'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header text
              Text(
                isEditing
                    ? 'Update employee details below:'
                    : 'Fill all basic details to add employee:',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // 1. Employee ID
              TextFormField(
                controller: idController,
                enabled: !isEditing, // don't change ID when editing
                decoration: InputDecoration(
                  labelText: 'Employee ID *',
                  hintText: 'e.g. EMP-101',
                  prefixIcon: const Icon(Icons.badge),
                  border: const OutlineInputBorder(),
                  filled: isEditing,
                  fillColor: isEditing ? Colors.grey.shade200 : null,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter Employee ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 2. Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'e.g. Rahul Sharma',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter employee name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 3. Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address *',
                  hintText: 'e.g. rahul@ems.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter email';
                  }
                  if (!val.contains('@') || !val.contains('.')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 4. Mobile
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number *',
                  hintText: 'e.g. +91 9876543210',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 5. Country
              TextFormField(
                controller: countryController,
                decoration: const InputDecoration(
                  labelText: 'Country *',
                  hintText: 'e.g. India',
                  prefixIcon: Icon(Icons.public),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 6. State
              TextFormField(
                controller: stateController,
                decoration: const InputDecoration(
                  labelText: 'State *',
                  hintText: 'e.g. Maharashtra',
                  prefixIcon: Icon(Icons.map),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter state';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 7. District
              TextFormField(
                controller: districtController,
                decoration: const InputDecoration(
                  labelText: 'District *',
                  hintText: 'e.g. Pune',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter district';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: saveEmployee,
                  child: Text(
                    isEditing ? 'UPDATE EMPLOYEE' : 'SAVE EMPLOYEE',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
