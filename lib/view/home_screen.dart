

import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import '../controller/employee_controller.dart';
import '../model/employee_model.dart';
import 'add_edit_employee_screen.dart';
import 'employee_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthController authController;

  const HomeScreen({super.key, required this.authController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Employee controller instance (manages employee list & search/filter)
  final EmployeeController employeeController = EmployeeController();

  // Search by ID controller
  final TextEditingController searchIdController = TextEditingController();

  // Filter text controller
  final TextEditingController filterTextController = TextEditingController();

  // Currently selected filter type
  String selectedFilter = 'All';

  @override
  void dispose() {
    searchIdController.dispose();
    filterTextController.dispose();
    super.dispose();
  }

  // Delete confirmation alert dialog
  void confirmDelete(EmployeeModel emp) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Employee?'),
        content: Text('Are you sure you want to remove ${emp.name} (${emp.id})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              employeeController.deleteEmployee(emp.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${emp.name} deleted successfully!')),
              );
            },
            child: const Text('DELETE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Open Add Employee screen
  void openAddEmployee() async {
    final newEmp = await Navigator.push<EmployeeModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditEmployeeScreen(),
      ),
    );

    if (newEmp != null) {
      employeeController.addEmployee(newEmp);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('${newEmp.name} added successfully! 🎉'),
          ),
        );
      }
    }
  }

  // Open Edit Employee screen with pre-populated data
  void openEditEmployee(EmployeeModel emp) async {
    final updatedEmp = await Navigator.push<EmployeeModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEmployeeScreen(employee: emp),
      ),
    );

    if (updatedEmp != null) {
      employeeController.updateEmployee(updatedEmp);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Text('${updatedEmp.name} updated successfully!'),
          ),
        );
      }
    }
  }

  // Open View Employee details screen
  void openViewEmployee(EmployeeModel emp) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailScreen(
          employee: emp,
          onEdit: (updated) {
            employeeController.updateEmployee(updated);
          },
          onDelete: (id) {
            employeeController.deleteEmployee(id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Management System'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Add Employee'),
        onPressed: openAddEmployee,
      ),
      body: ListenableBuilder(
        listenable: employeeController,
        builder: (context, _) {
          final employees = employeeController.employeeList;

          return RefreshIndicator(
            onRefresh: employeeController.refreshEmployees,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Search employees by ID
                  TextField(
                    controller: searchIdController,
                    onChanged: (val) {
                      employeeController.setSearchId(val);
                    },
                    decoration: InputDecoration(
                      labelText: 'Search Employee by ID',
                      hintText: 'e.g. EMP-101',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchIdController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchIdController.clear();
                                employeeController.setSearchId('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. Filter row (Filter by Name, Email, Mobile, or Country)
                  Row(
                    children: [
                      const Text(
                        'Filter By: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton<String>(
                          value: selectedFilter,
                          underline: const SizedBox(),
                          isDense: true,
                          items: employeeController.filterTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type, style: const TextStyle(fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                selectedFilter = val;
                              });
                              employeeController.setFilter(filterTextController.text, selectedFilter);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: filterTextController,
                          onChanged: (val) {
                            employeeController.setFilter(val, selectedFilter);
                          },
                          decoration: InputDecoration(
                            hintText: 'Type to filter...',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Count indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${employees.length} Employee(s)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        'Pull down to refresh ⬇️',
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Loading indicator or Employee list
                  if (employeeController.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (employees.isEmpty)
                    // Empty state
                    Container(
                      padding: const EdgeInsets.all(32),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(Icons.person_off_outlined, size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'No Employees Found!',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try clearing search/filter or add a new employee using the + button.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    )
                  else
                    // Employee cards list
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        final emp = employees[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top row: Avatar + Name + ID Badge
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blue.shade100,
                                      child: Text(
                                        emp.name.isNotEmpty ? emp.name[0].toUpperCase() : 'E',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            emp.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade50,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              emp.id,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue.shade700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const Divider(height: 18),

                                // Required assignment fields: Email & Mobile
                                Row(
                                  children: [
                                    const Icon(Icons.email, size: 15, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        emp.email,
                                        style: const TextStyle(fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                Row(
                                  children: [
                                    const Icon(Icons.phone, size: 15, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Text(
                                      emp.mobile,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Location: District, State, Country
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 15, color: Colors.grey),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        '${emp.district}, ${emp.state}, ${emp.country}',
                                        style: const TextStyle(fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                // Action Buttons: View, Edit, Delete
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      icon: const Icon(Icons.visibility, size: 16),
                                      label: const Text('View'),
                                      onPressed: () => openViewEmployee(emp),
                                    ),
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.orange,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      icon: const Icon(Icons.edit, size: 16),
                                      label: const Text('Edit'),
                                      onPressed: () => openEditEmployee(emp),
                                    ),
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      icon: const Icon(Icons.delete, size: 16),
                                      label: const Text('Delete'),
                                      onPressed: () => confirmDelete(emp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 70), // space for floating action button
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
