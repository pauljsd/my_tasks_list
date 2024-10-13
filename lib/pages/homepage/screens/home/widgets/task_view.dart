import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_task_list/pages/homepage/controllers/clear_all_tasks.dart';
import 'package:my_task_list/pages/homepage/models/task.dart';
import 'package:my_task_list/pages/homepage/screens/home/widgets/delete_all_tasks_btn.dart';
import 'task_list.dart';

class TasksView extends StatefulWidget {
  final Function(Task task, int index) onEdit; // Pass the edit function

  const TasksView({super.key, required this.onEdit});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  Box? _box;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;

          return Column(
            children: [
              Expanded(child: TaskList(box: _box!, onEdit: widget.onEdit)),
              DeleteAllTasks(
                onPressed: () {
                  ClearAllTasks().clearBox();
                  setState(() {});
                },
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
