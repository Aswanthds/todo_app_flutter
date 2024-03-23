import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/widgets/edit_task.dart';
import 'package:intl/intl.dart';

class TodoPreviewPage extends StatelessWidget {
  final TodoModel data;

  const TodoPreviewPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditTodoPage(
                      data: data,
                    ));
              },
              icon: const Icon(Icons.edit_note_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                      data.isCompleted ?? true
                          ? Icons.done
                          : Icons.pending_actions,
                      color:
                          data.isCompleted ?? true ? Colors.green : Colors.red),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.isCompleted ?? true ? 'Completed' : 'Pending',
                    style: TextStyle(
                        fontSize: 16,
                        color: data.isCompleted ?? true
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "Created :  ${DateFormat(' dd- MMM - yyyy hh:mm:aa').format(data.createdAt!)}"),
              Text(
                  "Updated :  ${DateFormat(' dd- MMM - yyyy hh:mm:aa').format(data.updatedAt!)}"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Title ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                data.title ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              Text(
                data.description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
