import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/app_logger.dart';
import '../model/country_model.dart';
import '../model/employee_model.dart';

/// Custom Exception for API Errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException(status: $statusCode, message: $message)';
}

/// Abstract Employee Repository Interface (Clean Architecture)
abstract class EmployeeRepository {
  Future<List<CountryModel>> getCountries();
  Future<List<EmployeeModel>> getEmployees();
  Future<EmployeeModel> getEmployeeById(String id);
  Future<EmployeeModel> createEmployee(EmployeeModel employee);
  Future<EmployeeModel> updateEmployee(String id, EmployeeModel employee);
  Future<bool> deleteEmployee(String id);
}

/// Production implementation of EmployeeRepository connecting to MockAPI
class EmployeeRepositoryImpl implements EmployeeRepository {
  static const String baseUrl =
      'https://669b3f09276e45187d34eb4e.mockapi.io/api/v1';

  final http.Client client;

  EmployeeRepositoryImpl({http.Client? client})
      : client = client ?? http.Client();

  // 1. GET /country
  @override
  Future<List<CountryModel>> getCountries() async {
    final url = '$baseUrl/country';
    AppLogger.apiRequest('GET', url);

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      AppLogger.apiResponse('GET', url, response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CountryModel.fromJson(json)).toList();
      } else {
        final err = ApiException('Failed to load countries', response.statusCode);
        AppLogger.error('GET /country', err);
        throw err;
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      AppLogger.error('GET /country network failure', e);
      throw ApiException('Network error while fetching countries: $e');
    }
  }

  // 2. GET /employee — Get all employees
  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final url = '$baseUrl/employee';
    AppLogger.apiRequest('GET', url);

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      AppLogger.apiResponse('GET', url, response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        final err = ApiException('Failed to load employees', response.statusCode);
        AppLogger.error('GET /employee', err);
        throw err;
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      AppLogger.error('GET /employee network failure', e);
      throw ApiException('Network error while fetching employees: $e');
    }
  }

  // 3. GET /employee/:id — Get employee by ID
  @override
  Future<EmployeeModel> getEmployeeById(String id) async {
    final url = '$baseUrl/employee/$id';
    AppLogger.apiRequest('GET', url);

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      AppLogger.apiResponse('GET', url, response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return EmployeeModel.fromJson(data);
      } else if (response.statusCode == 404) {
        final err = ApiException('Employee not found with ID: $id', 404);
        AppLogger.error('GET /employee/$id', err);
        throw err;
      } else {
        final err = ApiException('Failed to fetch employee $id', response.statusCode);
        AppLogger.error('GET /employee/$id', err);
        throw err;
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      AppLogger.error('GET /employee/$id network failure', e);
      throw ApiException('Network error while fetching employee $id: $e');
    }
  }

  // 4. POST /employee — Create employee
  @override
  Future<EmployeeModel> createEmployee(EmployeeModel employee) async {
    final url = '$baseUrl/employee';
    final requestBody = jsonEncode(employee.toJson());
    AppLogger.apiRequest('POST', url, requestBody);

    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );
      AppLogger.apiResponse('POST', url, response.statusCode, response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return EmployeeModel.fromJson(data);
      } else {
        final err = ApiException('Failed to create employee', response.statusCode);
        AppLogger.error('POST /employee', err);
        throw err;
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      AppLogger.error('POST /employee network failure', e);
      throw ApiException('Network error while creating employee: $e');
    }
  }

  // 5. PUT /employee/:id — Update employee
  @override
  Future<EmployeeModel> updateEmployee(String id, EmployeeModel employee) async {
    final url = '$baseUrl/employee/$id';
    final requestBody = jsonEncode(employee.toJson());
    AppLogger.apiRequest('PUT', url, requestBody);

    try {
      final response = await client.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );
      AppLogger.apiResponse('PUT', url, response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return EmployeeModel.fromJson(data);
      } else {
        final err = ApiException('Failed to update employee $id', response.statusCode);
        AppLogger.error('PUT /employee/$id', err);
        throw err;
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      AppLogger.error('PUT /employee/$id network failure', e);
      throw ApiException('Network error while updating employee: $e');
    }
  }

  // 6. DELETE /employee/:id — Delete employee
  @override
  Future<bool> deleteEmployee(String id) async {
    final url = '$baseUrl/employee/$id';
    AppLogger.apiRequest('DELETE', url);

    try {
      final response = await client.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      AppLogger.apiResponse('DELETE', url, response.statusCode, response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        final err = ApiException('Failed to delete employee $id', response.statusCode);
        AppLogger.error('DELETE /employee/$id', err);
        throw err;
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      AppLogger.error('DELETE /employee/$id network failure', e);
      throw ApiException('Network error while deleting employee: $e');
    }
  }
}
