import 'package:flutter/material.dart';
import 'package:my_task_list/pages/homepage/controllers/clear_all_tasks.dart';

class DeleteAllTasks extends StatefulWidget {
  final VoidCallback? onPressed;

  const DeleteAllTasks({super.key, this.onPressed});

  @override
  State<DeleteAllTasks> createState() => _DeleteAllTasksState();
}

class _DeleteAllTasksState extends State<DeleteAllTasks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: widget.onPressed,
        // onPressed: clearBox,
        child: Text("Delete"),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          // primary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
    );
  }
}
