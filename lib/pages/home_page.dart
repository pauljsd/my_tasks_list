import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:my_task_list/models/task.dart';

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
          toolbarHeight: _deviceHeight * 0.10,
          title: const Text(
            'TRACK YOUR DAY',
            style: TextStyle(fontSize: 25, color: Colors.white),
          )),
      // body: _tasksList(),
      body: Container(
        color: Colors.blue.withOpacity(0.3),
        child: _tasksView(),
      ),

      // body: const Text('hello'),
      floatingActionButton: _addTaskButton(),
    );
  }

  /// this widget shows the circularProgress bar till the data in openBox is available

  Widget _tasksView() {
    return FutureBuilder(
        //this fetched the data in hive_boxes which will be == _snapshot???
        future: Hive.openBox(
            'tasks'), //this will return a box, that is why the snapshot is equated to a Box data type bro

        // future: Future.delayed(Duration(seconds: 4)),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;

            return _tasksList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _tasksList() {
    //create a new task into hive manually
    // Task _newTask = Task(
    //   content: 'Now we are good',
    //   timestamp: DateTime.now(),
    //   done: false,
    // );

    //add the task to the box in the hive
    // _box?.add(_newTask.toMap());

    List tasks = _box!.values.toList();

    print('I AM PRINTING HERE');
    print(tasks);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (BuildContext _context, int _index) {
              var task = Task.fromMap(tasks[_index]);

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
                    color:
                        task.done ? Colors.green : Colors.pink.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _editTaskDialog(task, _index);
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
                  task.done = !task.done;
                  _box!.putAt(_index, task.toMap());
                  setState(() {});
                },
                onLongPress: () {
                  _box!.delete(_index);
                  setState(() {});
                },
              );
            },
          ),
        ),

        //Delete button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            onPressed: clearBox,
            child: Text("Delete All Tasks"),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              // primary: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }

//delete all task function
  void clearBox() async {
    var box = await Hive.openBox('tasks');
    box.clear();
    setState(() {});
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: _popUpTaskTodo,
      // onPressed: clearBox,

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
}
