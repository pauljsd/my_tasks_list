import 'package:flutter/material.dart';

class PopUpTaskTodo extends StatefulWidget {
  final Function(String) onTaskAdded;

  const PopUpTaskTodo({required this.onTaskAdded, Key? key}) : super(key: key);

  @override
  _PopUpTaskTodoState createState() => _PopUpTaskTodoState();
}

class _PopUpTaskTodoState extends State<PopUpTaskTodo> {
  String _taskContent = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add to List'),
      content: TextField(
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            _taskContent = value;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_taskContent.isNotEmpty) {
              widget.onTaskAdded(_taskContent);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
