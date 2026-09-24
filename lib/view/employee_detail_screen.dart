

import 'package:flutter/material.dart';
import '../model/employee_model.dart';
import 'add_edit_employee_screen.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final EmployeeModel employee;
  final Function(EmployeeModel updated)? onEdit;
  final Function(String id)? onDelete;

  const EmployeeDetailScreen({
    super.key,
    required this.employee,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  late EmployeeModel currentEmployee;

  @override
  void initState() {
    super.initState();
    currentEmployee = widget.employee;
  }

  // Delete employee confirmation dialog
  void showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete ${currentEmployee.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              widget.onDelete?.call(currentEmployee.id);
              Navigator.pop(context); // Go back to employee list
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Open Edit Screen
  void openEditScreen() async {
    final updated = await Navigator.push<EmployeeModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEmployeeScreen(employee: currentEmployee),
      ),
    );

    if (updated != null) {
      setState(() {
        currentEmployee = updated;
      });
      widget.onEdit?.call(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Employee',
            onPressed: openEditScreen,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Employee',
            onPressed: showDeleteConfirmation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Avatar with initial
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                currentEmployee.name.isNotEmpty ? currentEmployee.name[0].toUpperCase() : 'E',
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 12),

            // Employee Name
            Text(
              currentEmployee.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),

            // Employee ID badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                'ID: ${currentEmployee.id}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),

            // All required details cards
            _buildDetailCard(Icons.email, 'Email Address', currentEmployee.email),
            _buildDetailCard(Icons.phone, 'Mobile Number', currentEmployee.mobile),
            _buildDetailCard(Icons.public, 'Country', currentEmployee.country),
            _buildDetailCard(Icons.map, 'State', currentEmployee.state),
            _buildDetailCard(Icons.location_city, 'District', currentEmployee.district),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(
          value.isNotEmpty ? value : 'N/A',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
      ),
    );
  }
}
