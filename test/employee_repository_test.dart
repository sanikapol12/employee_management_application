import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:employee_management_application/model/employee_model.dart';
import 'package:employee_management_application/repository/employee_repository.dart';

void main() {
  group('EmployeeRepositoryImpl API Tests (Mocked)', () {
    test('getEmployees returns list of EmployeeModel on 200 OK', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/api/v1/employee');
        expect(request.method, 'GET');
        return http.Response(
          jsonEncode([
            {
              'id': '101',
              'name': 'Aarav Patel',
              'email': 'aarav@ems.com',
              'mobile': '9876543210',
              'country': 'India',
              'state': 'Maharashtra',
              'district': 'Pune',
              'avatar': 'https://avatars.example.com/101.jpg',
            }
          ]),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);
      final employees = await repository.getEmployees();

      expect(employees.length, 1);
      expect(employees.first.id, '101');
      expect(employees.first.name, 'Aarav Patel');
      expect(employees.first.country, 'India');
    });

    test('getCountries returns list of CountryModel on 200 OK', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/api/v1/country');
        expect(request.method, 'GET');
        return http.Response(
          jsonEncode([
            {
              'id': '1',
              'country': 'India',
              'flag': 'https://flag.example.com/in.png',
            }
          ]),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);
      final countries = await repository.getCountries();

      expect(countries.length, 1);
      expect(countries.first.id, '1');
      expect(countries.first.country, 'India');
    });

    test('getEmployeeById returns single EmployeeModel on 200 OK', () async {
      final mockClient = MockClient((request) async {
        expect(request.url.path, '/api/v1/employee/101');
        return http.Response(
          jsonEncode({
            'id': '101',
            'name': 'Aarav Patel',
            'email': 'aarav@ems.com',
            'mobile': '9876543210',
            'country': 'India',
            'state': 'Maharashtra',
            'district': 'Pune',
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);
      final employee = await repository.getEmployeeById('101');

      expect(employee.id, '101');
      expect(employee.name, 'Aarav Patel');
    });

    test('createEmployee posts employee and returns created object on 201',
        () async {
      final newEmp = EmployeeModel(
        id: '202',
        name: 'Sara Khan',
        email: 'sara@ems.com',
        mobile: '9123456780',
        country: 'India',
        state: 'Delhi',
        district: 'New Delhi',
      );

      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/api/v1/employee');
        final decoded = jsonDecode(request.body);
        expect(decoded['name'], 'Sara Khan');
        return http.Response(
          jsonEncode({
            'id': '202',
            'name': 'Sara Khan',
            'email': 'sara@ems.com',
            'mobile': '9123456780',
            'country': 'India',
            'state': 'Delhi',
            'district': 'New Delhi',
          }),
          201,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);
      final result = await repository.createEmployee(newEmp);

      expect(result.id, '202');
      expect(result.name, 'Sara Khan');
    });

    test('updateEmployee sends PUT and returns updated object on 200', () async {
      final updatedEmp = EmployeeModel(
        id: '101',
        name: 'Aarav Patel Updated',
        email: 'aarav@ems.com',
        mobile: '9999999999',
        country: 'India',
        state: 'Maharashtra',
        district: 'Pune',
      );

      final mockClient = MockClient((request) async {
        expect(request.method, 'PUT');
        expect(request.url.path, '/api/v1/employee/101');
        return http.Response(
          jsonEncode(updatedEmp.toJson()),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);
      final result = await repository.updateEmployee('101', updatedEmp);

      expect(result.name, 'Aarav Patel Updated');
      expect(result.mobile, '9999999999');
    });

    test('deleteEmployee sends DELETE and returns true on 200', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'DELETE');
        expect(request.url.path, '/api/v1/employee/101');
        return http.Response(
          jsonEncode({'id': '101'}),
          200,
        );
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);
      final success = await repository.deleteEmployee('101');

      expect(success, isTrue);
    });

    test('throws ApiException on 404 or 500 error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Server Error', 500);
      });

      final repository = EmployeeRepositoryImpl(client: mockClient);

      expect(() => repository.getEmployees(), throwsA(isA<ApiException>()));
    });
  });
}
