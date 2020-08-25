//import 'dart:convert';
//import 'package:http/http.dart'
//    as http; // add the http plugin in pubspec.yaml file.
//import 'Student.dart';
//
//class Services {
//  // Method to create the table Employees.
//  static Future<String> createTable() async {
//    try {
//      // add the parameters to pass to the request.
//      var map = Map<String, dynamic>();
//      map['action'] = _CREATE_TABLE_ACTION;
//      final response = await http.post(ROOT, body: map);
//      print('Create Table Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  static Future<List<Student>> getEmployees() async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _GET_ALL_ACTION;
//      final response = await http.post(ROOT, body: map);
//      print('getEmployees Response: ${response.body}');
//      if (200 == response.statusCode) {
//        List<Student> list = parseResponse(response.body);
//        return list;
//      } else {
//        return List<Student>();
//      }
//    } catch (e) {
//      return List<Student>(); // return an empty list on exception/error
//    }
//  }
//
//  static List<Student> parseResponse(String responseBody) {
//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
//  }
//
//  // Method to add employee to the database...
//  static Future<String> addEmployee(String firstName, String lastName) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _ADD_EMP_ACTION;
//      map['first_name'] = firstName;
//      map['last_name'] = lastName;
//      final response = await http.post(ROOT, body: map);
//      print('addEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  // Method to update an Employee in Database...
//  static Future<String> updateEmployee(
//      String empId, String firstName, String lastName) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _UPDATE_EMP_ACTION;
//      map['emp_id'] = empId;
//      map['first_name'] = firstName;
//      map['last_name'] = lastName;
//      final response = await http.post(ROOT, body: map);
//      print('updateEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  // Method to Delete an Employee from Database...
//  static Future<String> deleteEmployee(String empId) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = _DELETE_EMP_ACTION;
//      map['emp_id'] = empId;
//      final response = await http.post(ROOT, body: map);
//      print('deleteEmployee Response: ${response.body}');
//      if (200 == response.statusCode) {
//        return response.body;
//      } else {
//        return "error";
//      }
//    } catch (e) {
//      return "error"; // returning just an "error" string to keep this simple...
//    }
//  }
//}
