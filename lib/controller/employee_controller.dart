import 'package:flutter/material.dart';
import '../core/app_logger.dart';
import '../model/country_model.dart';
import '../model/employee_model.dart';
import '../repository/employee_repository.dart';

class EmployeeController extends ChangeNotifier {
  final EmployeeRepository _repository;

  // Main list storing all employee records
  List<EmployeeModel> _employees = [
    EmployeeModel(
      id: '1',
      name: 'Rahul Sharma',
      email: 'rahul.sharma@ems.com',
      mobile: '+91 9876543210',
      country: 'India',
      state: 'Maharashtra',
      district: 'Pune',
    ),
    EmployeeModel(
      id: '2',
      name: 'Priya Patel',
      email: 'priya.patel@ems.com',
      mobile: '+91 9822334455',
      country: 'India',
      state: 'Gujarat',
      district: 'Ahmedabad',
    ),
    EmployeeModel(
      id: '3',
      name: 'John Miller',
      email: 'john.miller@ems.com',
      mobile: '+1 4155552671',
      country: 'United States',
      state: 'California',
      district: 'San Francisco',
    ),
    EmployeeModel(
      id: '4',
      name: 'Ananya Deshmukh',
      email: 'ananya.d@ems.com',
      mobile: '+91 9123456780',
      country: 'India',
      state: 'Maharashtra',
      district: 'Mumbai',
    ),
    EmployeeModel(
      id: '5',
      name: 'David Wilson',
      email: 'david.w@ems.com',
      mobile: '+44 2079460912',
      country: 'United Kingdom',
      state: 'Greater London',
      district: 'Westminster',
    ),
  ];

  // List of countries from API
  List<CountryModel> _countries = [];

  // Search and filter queries
  String _searchIdQuery = '';
  String _filterQuery = '';
  String _selectedFilterType = 'All'; // 'All', 'Name', 'Email', 'Mobile', 'Country'
  bool _isLoading = false;
  String _errorMessage = '';

  EmployeeController({EmployeeRepository? repository})
      : _repository = repository ?? EmployeeRepositoryImpl();

  // Getters
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedFilterType => _selectedFilterType;
  List<CountryModel> get countries => _countries;
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
    AppLogger.activity('Search by ID filter changed', {'searchId': _searchIdQuery});
    notifyListeners();
  }

  // Set Filter query and type
  void setFilter(String query, String filterType) {
    _filterQuery = query.trim();
    _selectedFilterType = filterType;
    AppLogger.activity('Employee filter changed', {'query': _filterQuery, 'filterType': _selectedFilterType});
    notifyListeners();
  }

  // Fetch employees from API (GET /employee)
  Future<void> fetchEmployees() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    AppLogger.activity('Fetching all employees from API');

    try {
      final fetchedList = await _repository.getEmployees();
      if (fetchedList.isNotEmpty) {
        _employees = fetchedList;
      }
      _isLoading = false;
      notifyListeners();
      AppLogger.activity('Employees successfully loaded', {'count': _employees.length});
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      AppLogger.error('fetchEmployees', e);
    }
  }

  // Fetch countries from API (GET /country)
  Future<List<CountryModel>> fetchCountries() async {
    AppLogger.activity('Fetching countries list from API');
    try {
      final list = await _repository.getCountries();
      _countries = list;
      notifyListeners();
      AppLogger.activity('Countries successfully loaded', {'count': list.length});
      return list;
    } catch (e) {
      AppLogger.error('fetchCountries', e);
      return _countries;
    }
  }

  // Fetch single employee by ID from API (GET /employee/:id)
  Future<EmployeeModel?> getEmployeeById(String id) async {
    AppLogger.activity('Fetching employee by ID', {'id': id});
    try {
      final emp = await _repository.getEmployeeById(id);
      AppLogger.activity('Employee retrieved by ID', {'id': id, 'name': emp.name});
      return emp;
    } catch (e) {
      AppLogger.error('getEmployeeById($id)', e);
      return null;
    }
  }

  // Add new employee via API (POST /employee)
  Future<bool> addEmployee(EmployeeModel newEmp) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    AppLogger.activity('Adding new employee', {'name': newEmp.name, 'email': newEmp.email});

    try {
      final createdEmp = await _repository.createEmployee(newEmp);
      _employees.insert(0, createdEmp);
      _isLoading = false;
      notifyListeners();
      AppLogger.activity('Employee successfully created on server', {'id': createdEmp.id, 'name': createdEmp.name});
      return true;
    } catch (e) {
      // Offline fallback: save locally
      _employees.insert(0, newEmp);
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      AppLogger.error('addEmployee server call failed, saved locally', e);
      return false;
    }
  }

  // Edit / Update existing employee via API (PUT /employee/:id)
  Future<bool> updateEmployee(EmployeeModel updatedEmp) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    AppLogger.activity('Updating employee', {'id': updatedEmp.id, 'name': updatedEmp.name});

    try {
      final savedEmp = await _repository.updateEmployee(updatedEmp.id, updatedEmp);
      final index = _employees.indexWhere((e) => e.id == updatedEmp.id);
      if (index != -1) {
        _employees[index] = savedEmp;
      }
      _isLoading = false;
      notifyListeners();
      AppLogger.activity('Employee successfully updated on server', {'id': savedEmp.id, 'name': savedEmp.name});
      return true;
    } catch (e) {
      // Offline fallback: update locally
      final index = _employees.indexWhere((e) => e.id == updatedEmp.id);
      if (index != -1) {
        _employees[index] = updatedEmp;
      }
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      AppLogger.error('updateEmployee server call failed, updated locally', e);
      return false;
    }
  }

  // Delete employee by ID via API (DELETE /employee/:id)
  Future<bool> deleteEmployee(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    AppLogger.activity('Deleting employee', {'id': id});

    try {
      await _repository.deleteEmployee(id);
      _employees.removeWhere((e) => e.id == id);
      _isLoading = false;
      notifyListeners();
      AppLogger.activity('Employee successfully deleted on server', {'id': id});
      return true;
    } catch (e) {
      // Offline fallback: remove locally
      _employees.removeWhere((e) => e.id == id);
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      AppLogger.error('deleteEmployee server call failed, removed locally', e);
      return false;
    }
  }

  // Pull to refresh employee data
  Future<void> refreshEmployees() async {
    AppLogger.activity('Pull-to-refresh triggered');
    await fetchEmployees();
  }
}
