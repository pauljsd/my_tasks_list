import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      // onPressed: _popUpTaskTodo,
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}
