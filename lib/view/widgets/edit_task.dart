import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_app_flutter/models/todo_model.dart';
import 'package:todo_app_flutter/view/home.dart';
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
                    () => Get.to(() => const MyHomePage()),
                  );
                }
              },
              icon: const Icon(Icons.save_alt))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  _isCompleted ? 'Completed' : 'Pending',
                  style: TextStyle(
                      fontSize: 16,
                      color: _isCompleted ? Colors.green : Colors.red),
                ),
                const SizedBox(
                  width: 10,
                ),
                Checkbox(
                    value: _isCompleted,
                    onChanged: (value) {
                      setState(() {
                        _isCompleted = value!;
                      });
                    }),
              ],
            ),
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
            const SizedBox(height: 20),
            const SizedBox(height: 15.0),
            Container(
              height: MediaQuery.of(context).size.width,
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
