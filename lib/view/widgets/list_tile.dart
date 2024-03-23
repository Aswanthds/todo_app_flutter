import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/widgets/edit_task.dart';
import 'package:todo_app_flutter/view/widgets/preview.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

class TodoTabScreen extends StatelessWidget {
  final TodoModel data;
  const TodoTabScreen({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApiController>();
    return ListTile(
      onTap: () {
        Get.to(
          () => TodoPreviewPage(
            data: data,
          ),
        );
      },
      title: Text(
        data.title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        data.description ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: PopupMenuButton<int>(
        icon: const Icon(Icons.more_horiz_rounded),
        padding: EdgeInsets.zero,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 2,
            onTap: () {
              controller.updateTodo(
                id: data.id ?? '',
                title: data.title ?? '',
                desp: data.description ?? '',
                isCompleted: !data.isCompleted!,
                created: data.createdAt ?? DateTime.now(),
              );
              !data.isCompleted!
                  ? Get.showSnackbar(const GetSnackBar(
                      backgroundColor: Colors.orange,
                      duration: Duration(seconds: 2),
                      borderRadius: 15,
                      message: 'Task Marked as Completed',
                      snackPosition: SnackPosition.TOP,
                      messageText: Text("Task Marked as Completed"),
                    ))
                  : Get.showSnackbar(const GetSnackBar(
                      backgroundColor: Colors.orange,
                      duration: Duration(seconds: 2),
                      borderRadius: 15,
                      message: 'Task Marked as Pending',
                      snackPosition: SnackPosition.TOP,
                      messageText: Text("Task Marked as Pending")));
            },
            child: Row(
              children: [
                Icon(!data.isCompleted!
                    ? Icons.done_outline_rounded
                    : Icons.pending_actions_rounded),
                const SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                !data.isCompleted!
                    ? const Text(" Mark as completed")
                    : const Text(" Mark as Pending")
              ],
            ),
          ),
          PopupMenuItem(
            value: 1,
            onTap: () {
              Get.to(() => EditTodoPage(data: data));
            },
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Row(
              children: [
                Icon(Icons.edit_document),
                SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                Text("Edit")
              ],
            ),
          ),
          // popupmenu item 2
          PopupMenuItem(
            value: 2,
            onTap: () {
              controller.deleteAnTask(data.id ?? '');
            },
            child: const Row(
              children: [
                Icon(Icons.remove),
                SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                Text("Delete")
              ],
            ),
          ),
        ],
        offset: const Offset(-10, 30),
        //color: Colors.grey,
        elevation: 2,
      ),
    );
  }
}
