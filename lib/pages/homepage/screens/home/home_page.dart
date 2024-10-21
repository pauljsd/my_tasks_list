import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_task_list/commons/rounded_container.dart';
import 'package:my_task_list/pages/homepage/controllers/clear_all_tasks.dart';

import 'package:my_task_list/pages/homepage/models/task.dart';
import 'package:my_task_list/pages/homepage/screens/home/widgets/app_bar_hamburger.dart';
import 'package:my_task_list/pages/homepage/screens/home/widgets/delete_all_tasks_btn.dart';
import 'package:my_task_list/pages/homepage/screens/home/widgets/pop_up_task_todo.dart';
import 'package:my_task_list/pages/homepage/screens/home/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  late double _deviceHeight, _deviceWidth;
  String _todoTaskContent = "";
  Box? _box;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Hamburger(),
        toolbarHeight: _deviceHeight * 0.10,
        title: const Text(
          'TRACK YOUR DAY',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),

      // body: _tasksList(),
      body: Container(
        color: Colors.blue.withOpacity(0.3),
        child: _tasksView(),
        // child: TasksView(onEdit: _editTaskDialog),
      ),

      // body: const Text('hello'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// this widget shows the circularProgress bar till the data in openBox is available

  Widget _tasksView() {
    return FutureBuilder(
        //this fetched the data in hive_boxes which will be == _snapshot???
        future: Future.wait([
          Hive.openBox('tasks'),
          Hive.openBox('history'),
        ]),
        // future: Hive.openBox('history'),

        // future: Future.delayed(Duration(seconds: 4)),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            var taskBox = _snapshot.data![0];
            _box = taskBox;

            // return _tasksList();
            return Column(
              children: [
                Expanded(child: TaskList(box: _box!, onEdit: _editTaskDialog)),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 40, 9),
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: _moveTasksToHistory,
                            child: Text('Move to History')),
                        DeleteAllTasks(
                          onPressed: () {
                            ClearAllTasks().clearBox();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  void _moveTasksToHistory() async {
    var tasksBox = Hive.box('tasks');
    var historyBox = Hive.box('history');

    // Get all tasks from the tasks box
    final tasks = tasksBox.values.toList();

    print(tasks);

    //check if any of the task is done
    bool isAnyDone = tasks.any((task) => task['done'] == true);

    print(tasks);

    if (!isAnyDone) {
      print('No task is done. Stopping execution.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Hello!, none of the task is done')),
      );
      return;
    }

    // Get today's date as a key in the format of 'yyyy-MM-dd'
    String currentDate = DateTime.now().toIso8601String().split('T')[0];

    // Check if the history box already contains tasks for today's date
    List<dynamic>? existingTasks = historyBox.get(currentDate);

    // If tasks exist for today, append to the list, otherwise create a new list
    List<dynamic> updatedTasks =
        existingTasks != null ? List.from(existingTasks) : [];
    updatedTasks.addAll(tasks);

    // Save the updated task list to the history box under the current date
    await historyBox.put(currentDate, updatedTasks);

    // Clear all tasks from the tasks box
    await tasksBox.clear();

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.green,
          content: Text('All tasks moved to history for $currentDate.')),
    );

    setState(() {});
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpTaskTodo(
          onTaskAdded: (taskContent) {
            var task = Task(
              content: taskContent,
              timestamp: DateTime.now(),
              done: false,
            );
            _box!.add(task.toMap());
            setState(() {});
          },
        );
      },
    );
  }

  //edit Task function
  void _editTaskDialog(Task task, int index) {
    TextEditingController _editController =
        TextEditingController(text: task.content);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(
              hintText: 'Enter new task content',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  task.content = _editController.text;
                  _box!.putAt(index, task.toMap());
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Widget _tasksList() {
  //   List tasks = _box!.values.toList();

  //   print('I AM PRINTING HERE');
  //   print(tasks);

  //   return Column(
  //     children: [
  //       Expanded(
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: tasks.length,
  //           itemBuilder: (BuildContext _context, int _index) {
  //             var task = Task.fromMap(tasks[_index]);

  //             return ListTile(
  //               title: Text(
  //                 task.content,
  //                 style: TextStyle(
  //                   decoration: task.done ? TextDecoration.lineThrough : null,
  //                   fontSize: 20,
  //                 ),
  //               ),
  //               subtitle: Text(
  //                 task.done
  //                     ? "Done ${DateFormat("d'th'-MMM-yyyy h:mma").format(task.timestamp)}"
  //                     : "Task added on ${DateFormat("d'th'-MMM-yyyy h:mma").format(task.timestamp)}",
  //                 style: TextStyle(
  //                   color:
  //                       task.done ? Colors.green : Colors.pink.withOpacity(0.8),
  //                   fontSize: 14,
  //                 ),
  //               ),
  //               trailing: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   IconButton(
  //                     onPressed: () {
  //                       _editTaskDialog(task, _index);
  //                     },
  //                     icon: const Icon(Icons.edit),
  //                     color: Colors.blue,
  //                   ),
  //                   Icon(
  //                     task.done
  //                         ? Icons.check_box_outlined
  //                         : Icons.check_box_outline_blank,
  //                     color: Colors.blue,
  //                   ),
  //                 ],
  //               ),
  //               onTap: () {
  //                 task.done = !task.done;
  //                 _box!.putAt(_index, task.toMap());
  //                 setState(() {});
  //               },
  //               onLongPress: () {
  //                 _box!.delete(_index);
  //                 setState(() {});
  //               },
  //             );
  //           },
  //         ),
  //       ),

  //       //Delete button
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: TextButton(
  //           onPressed: () {
  //             ClearAllTasks().clearBox();
  //             setState(() {});
  //           },
  //           // onPressed: clearBox,
  //           child: Text("Delete All Tasks"),
  //           style: TextButton.styleFrom(
  //             backgroundColor: Colors.blue,
  //             // primary: Colors.white,
  //             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: _popUpTaskTodo,
      child: Icon(Icons.add),
    );
  }

  void _popUpTaskTodo() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: Text('Add to List'),
            content: TextField(
              keyboardType: TextInputType.text,
              onChanged: (_value) {
                setState(() {
                  _todoTaskContent = _value;
                });
              },
              onSubmitted: (_value) {
                if (_todoTaskContent != null) {
                  var task = Task(
                      content: _todoTaskContent,
                      timestamp: DateTime.now(),
                      done: false);
                  _box!.add(task.toMap());
                  setState(() {
                    Navigator.pop(context);
                    _todoTaskContent = '';
                  });
                }
              },
            ),
          );
        });
  }
}
