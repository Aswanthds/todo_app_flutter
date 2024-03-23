import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/utils/functions/api_functions.dart';

class ApiController extends GetxController {
  RxList list = [].obs;

  RxList completedTasks = [].obs;
  RxList incompleteTasks = [].obs;
  RxList suggestions = [].obs;
  RxList filterlist = [].obs;

  getTodoListData() async {
    list.value = await ApiFunctions.getallData();
    list.sort((task1, task2) {
      DateTime dateTime1 = DateTime.parse(task1['updated_at']);
      DateTime dateTime2 = DateTime.parse(task2['updated_at']);
      return dateTime2.compareTo(dateTime1);
    });
    _filterTasks();
  }

  deleteAnTask(String id) async {
    ApiFunctions.deleteAtask(id);
    await getTodoListData();
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      borderRadius: 15,
      message: 'Task Deleted',
      snackPosition: SnackPosition.TOP,
      messageText: Text("Todo task deleted"),
    ));
  }

  addATask(String title, String description) async {
    ApiFunctions.addTodo(title, description, false);

    await getTodoListData();
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      borderRadius: 15,
      message: 'Task Added',
      snackPosition: SnackPosition.TOP,
      messageText: Text("Todo task added"),
    ));
  }

  updateTodo(
      {required String id,
      required String title,
      required String desp,
      required DateTime created,
      required bool isCompleted}) async {
    ApiFunctions.updateTodo(id, title, desp, isCompleted);
    await getTodoListData();
  }

  void _filterTasks() {
    completedTasks
        .assignAll(list.where((task) => task['is_completed'] == true));
    incompleteTasks
        .assignAll(list.where((task) => task['is_completed'] == false));
  }

  void searchTodos(String searchQuery) {
    final lowercaseQuery = searchQuery.toLowerCase();
    filterlist.value = list
        .where((todo) =>
            todo.title?.toLowerCase().contains(lowercaseQuery) ?? false)
        .toList();
  }
}
