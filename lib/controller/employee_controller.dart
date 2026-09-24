

import 'package:flutter/material.dart';
import '../model/employee_model.dart';

class EmployeeController extends ChangeNotifier {
  // Main list storing all employee records
  final List<EmployeeModel> _employees = [
    EmployeeModel(
      id: 'EMP-101',
      name: 'Rahul Sharma',
      email: 'rahul.sharma@ems.com',
      mobile: '+91 9876543210',
      country: 'India',
      state: 'Maharashtra',
      district: 'Pune',
    ),
    EmployeeModel(
      id: 'EMP-102',
      name: 'Priya Patel',
      email: 'priya.patel@ems.com',
      mobile: '+91 9822334455',
      country: 'India',
      state: 'Gujarat',
      district: 'Ahmedabad',
    ),
    EmployeeModel(
      id: 'EMP-103',
      name: 'John Miller',
      email: 'john.miller@ems.com',
      mobile: '+1 4155552671',
      country: 'United States',
      state: 'California',
      district: 'San Francisco',
    ),
    EmployeeModel(
      id: 'EMP-104',
      name: 'Ananya Deshmukh',
      email: 'ananya.d@ems.com',
      mobile: '+91 9123456780',
      country: 'India',
      state: 'Maharashtra',
      district: 'Mumbai',
    ),
    EmployeeModel(
      id: 'EMP-105',
      name: 'David Wilson',
      email: 'david.w@ems.com',
      mobile: '+44 2079460912',
      country: 'United Kingdom',
      state: 'Greater London',
      district: 'Westminster',
    ),
  ];

  // Search and filter queries
  String _searchIdQuery = '';
  String _filterQuery = '';
  String _selectedFilterType = 'All'; // 'All', 'Name', 'Email', 'Mobile', 'Country'
  bool _isLoading = false;

  // Getters
  bool get isLoading => _isLoading;
  String get selectedFilterType => _selectedFilterType;

  // Filter types available as requested in assignment
  List<String> get filterTypes => ['All', 'Name', 'Email', 'Mobile', 'Country'];

  // Getter that returns filtered and searched employees list
  List<EmployeeModel> get employeeList {
    return _employees.where((emp) {
      // 1. Search by ID (case insensitive)
      if (_searchIdQuery.isNotEmpty) {
        if (!emp.id.toLowerCase().contains(_searchIdQuery.toLowerCase())) {
          return false;
        }
      }

      // 2. Filter by Name, Email, Mobile, or Country
      if (_filterQuery.isNotEmpty) {
        final query = _filterQuery.toLowerCase();
        switch (_selectedFilterType) {
          case 'Name':
            return emp.name.toLowerCase().contains(query);
          case 'Email':
            return emp.email.toLowerCase().contains(query);
          case 'Mobile':
            return emp.mobile.toLowerCase().contains(query);
          case 'Country':
            return emp.country.toLowerCase().contains(query);
          case 'All':
          default:
            return emp.name.toLowerCase().contains(query) ||
                emp.email.toLowerCase().contains(query) ||
                emp.mobile.toLowerCase().contains(query) ||
                emp.country.toLowerCase().contains(query);
        }
      }

      return true;
    }).toList();
  }

  // Set Search by ID query
  void setSearchId(String id) {
    _searchIdQuery = id.trim();
    notifyListeners();
  }

  // Set Filter query and type
  void setFilter(String query, String filterType) {
    _filterQuery = query.trim();
    _selectedFilterType = filterType;
    notifyListeners();
  }

  // Add new employee
  void addEmployee(EmployeeModel newEmp) {
    _employees.insert(0, newEmp);
    notifyListeners();
  }

  // Edit / Update existing employee
  void updateEmployee(EmployeeModel updatedEmp) {
    final index = _employees.indexWhere((e) => e.id == updatedEmp.id);
    if (index != -1) {
      _employees[index] = updatedEmp;
      notifyListeners();
    }
  }

  // Delete employee by ID
  void deleteEmployee(String id) {
    _employees.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // Pull to refresh simulation (like API call delay)
  Future<void> refreshEmployees() async {
    _isLoading = true;
    notifyListeners();

    // Student delay simulating network call
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }
}
