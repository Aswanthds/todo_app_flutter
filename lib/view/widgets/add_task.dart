import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/view/widgets/textformfieldcolumn.dart';
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
        leading: IconButton(
            onPressed: () {
              if (_titleController.text.isEmpty ||
                  _descriptionController.text.isEmpty) {
              Get.back();
              }
                Get.showSnackbar( GetSnackBar(
                backgroundColor: Colors.redAccent,
                duration: const Duration(seconds: 2),
                borderRadius: 15,
               
                snackPosition: SnackPosition.TOP,
                messageText: Text("Save your task before navigating",style: Theme.of(context).textTheme.titleLarge,),
              ));
              
            },
            icon: const Icon(Icons.arrow_back_ios)),
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
        child: TexFieldColumnWidget(titleController: _titleController, descriptionController: _descriptionController),
      ),
    );
  }
}
