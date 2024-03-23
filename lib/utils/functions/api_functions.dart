import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:todo_app_flutter/utils/constants/appi.dart';

class ApiFunctions {
  static void addTodo(
    String title,
    String? description,
    bool isCompleted,
  ) async {
    try {
      final response = await http.post(Uri.parse(baseUrl), body: {
        "title": title,
        "description": description ?? '',
        "is_completed": '$isCompleted',
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.statusCode.toString());
        getallData();
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
      throw Exception("An error occured while getting error");
    }
  }

  static Future<List> getallData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map;
        final result = jsonData['items'] as List;
        log(response.body);
        return result;
      } else {
        log(response.statusCode.toString());
        return [];
      }
    } catch (e) {
      log(e.toString());
      throw Exception("An error occured while getting error");
    }
  }

  static Future<void> deleteAtask(String id) async {
    try {
      final response = await http.delete(Uri.parse(baseUrl + id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Delete Succesfull');
        log(response.statusCode.toString());
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
      throw Exception("An error occured while getting error");
    }
  }

  static Future<void> updateTodo(
      String id, String title, String description, bool isCompleted) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + id),
        body: {
          "title": title,
          "description": description,
          "is_completed": isCompleted.toString(),
        },
      );
      if (response.statusCode == 200) {
        log('Todo updated successfully');
      } else {
        log('Failed to update todo: ${response.statusCode}');
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      log('Error updating todo: $e');
      throw Exception('Error updating todo');
    }
  }
}
