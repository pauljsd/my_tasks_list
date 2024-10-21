import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_task_list/pages/homepage/models/task.dart';

class TaskList extends StatefulWidget {
  final Box box;
  final Function(Task task, int index) onEdit;

  const TaskList({required this.box, required this.onEdit, Key? key})
      : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    List tasks = widget.box.values.toList();

    // print(tasks);

    return ListView.builder(
      // shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        var task = Task.fromMap(tasks[index]);

        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              decoration: task.done ? TextDecoration.lineThrough : null,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            task.done
                ? "Done ${DateFormat("d'th'-MMM-yyyy h:mma").format(task.timestamp)}"
                : "Task added on ${DateFormat("d'th'-MMM-yyyy h:mma").format(task.timestamp)}",
            style: TextStyle(
              color: task.done ? Colors.green : Colors.pink.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (task.done) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("You can't edit a done task."),
                      duration:
                          Duration(seconds: 2), // How long the pop-up lasts
                    ));
                  } else {
                    widget.onEdit(task, index);
                  }
                },
                icon: const Icon(Icons.edit),
                color: Colors.blue,
              ),
              Icon(
                task.done
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                color: Colors.blue,
              ),
            ],
          ),
          onTap: () {
            // task.done = !task.done;
            if (!task.done) {
              task.done = true;
              task.timestamp = DateTime.now();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("You can't undo a done task."),
                  duration: Duration(seconds: 2), // How long the pop-up lasts
                ),
              );
            }
            widget.box.putAt(index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            widget.box.delete(index);
            setState(() {});
          },
        );
      },
    );
  }
}
