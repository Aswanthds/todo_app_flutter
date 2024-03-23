import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/widgets/list_tile.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

class TodoPageScreen extends StatelessWidget {
  const TodoPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiController>();
    controller.getTodoListData();
    return RefreshIndicator(
      onRefresh: () {
        return controller.getTodoListData();
      },
      child: Scaffold(
        body: Obx(() {
          if (controller.incompleteTasks.isEmpty) {
            return const Center(child: Text(' No Tasks to done'));
          }
          return ListView.builder(
              itemCount: controller.incompleteTasks.length,
              itemBuilder: (context, index) {
                // return Text(data.toString());
                var data = controller.incompleteTasks[index];
                return TodoTabScreen(
                  data: TodoModel.fromJson(data),
                );
              });
        }),
      ),
    );
  }
}
