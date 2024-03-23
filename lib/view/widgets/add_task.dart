import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final controller = Get.find<ApiController>();
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        actions: [
          IconButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  controller.addATask(_titleController.text.trim(),
                      _descriptionController.text.trim());
                }
                Get.back();
              },
              icon: const Icon(Icons.save_alt))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 25,
              decoration: InputDecoration(
                hintText: 'Task Title',
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              height: MediaQuery.of(context).size.width + 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.fromBorderSide(BorderSide(
                    style: BorderStyle.solid, color: Colors.white30)),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: '',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(15.0),
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
                maxLength: null,
                maxLengthEnforcement:
                    MaxLengthEnforcement.truncateAfterCompositionEnds,
                textInputAction: TextInputAction.newline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
