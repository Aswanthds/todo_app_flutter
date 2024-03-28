import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TexFieldColumnWidget extends StatelessWidget {
  const TexFieldColumnWidget({
    super.key,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  })  : _titleController = titleController,
        _descriptionController = descriptionController;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextField(
          controller: _titleController,
          maxLength: 25,
          style: Theme.of(context).textTheme.headlineSmall,
          decoration: const InputDecoration(
            hintText: 'Task Title',
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 15.0),
        Container(
          height: MediaQuery.of(context).size.longestSide,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.symmetric(
                horizontal: BorderSide(
                    style: BorderStyle.solid, color: Colors.white30)),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: null,
            textAlign: TextAlign.justify,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
            decoration: const InputDecoration(
              hintText: '',
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(5.0),
            ),
            style: const TextStyle(
              fontSize: 16.0,
            ),
            maxLength: null,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            textInputAction: TextInputAction.newline,
          ),
        ),
      ],
    );
  }
}
