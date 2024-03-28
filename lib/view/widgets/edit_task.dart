import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/home.dart';
import 'package:todo_app_flutter/view/widgets/textformfieldcolumn.dart';
import 'package:todo_app_flutter/viewmodel/getx_controller.dart';

class EditTodoPage extends StatefulWidget {
  final TodoModel data;

  const EditTodoPage({
    super.key,
    required this.data,
  });

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isCompleted = false;
  final controller = Get.find<ApiController>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.data.title ?? '';
    _descriptionController.text = widget.data.description ?? '';
    _isCompleted = widget.data.isCompleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  // ApiFunctions.addTodo(_titleController.text.trim(),
                  //     _descriptionController.text.trim(), false);
                  controller.updateTodo(
                    id: widget.data.id ?? '',
                    title: _titleController.text.trim(),
                    desp: _descriptionController.text.trim(),
                    isCompleted: _isCompleted,
                    created: widget.data.createdAt ?? DateTime.now(),
                  );
                  Future.delayed(
                    Durations.long4,
                    () => Get.off(() => const MyHomePage()),
                  );
                }
              },
              icon: const Icon(Icons.save_alt))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: TexFieldColumnWidget(descriptionController: _descriptionController,titleController: _titleController,)
        ),
      ),
    );
  }
}
