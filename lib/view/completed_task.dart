import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/widgets/list_tile.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

class CompletedTaskPageScreen extends StatelessWidget {
  const CompletedTaskPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiController>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return controller.getTodoListData();
        },
        child: Obx(
          () {
            if (controller.completedTasks.isEmpty) {
              return const Center(child: Text(' No completed Tasks'));
            }
            return ListView.builder(
                itemCount: controller.completedTasks.length,
                itemBuilder: (context, index) {
                  // return Text(data.toString());

                  var data = controller.completedTasks[index];
                  return TodoTabScreen(
                    data: TodoModel.fromJson(data),
                  );
                });
          },
        ),
      ),
    );
  }
}
