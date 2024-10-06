import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_task_list/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  late double _deviceHeight, _deviceWidth;
  String todoTaskContent = "";
  Box? _box;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: _deviceHeight * 0.15,
          title: const Text(
            'TO DO LIST',
            style: TextStyle(fontSize: 25, color: Colors.white),
          )),
      // body: _tasksList(),
      body: _tasksView(),
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
          if (_snapshot.connectionState == ConnectionState.done) {
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

    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int _index) {
          var task = Task.fromMap(tasks[_index]);
          return ListTile(
            title: Text(
              task.content,
              // "Good Good",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            subtitle: Text(
              // DateTime.now().toString(),
              task.timestamp.toString(),
            ),
            trailing: const Icon(Icons.check_box_outlined, color: Colors.blue),
          );
        });
  }

  // void clearBox() async {
  //   var box = await Hive.openBox('tasks');
  //   box.clear();
  //   print('yes cleared');
  // }

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
              onChanged: (_value) {},
              onSubmitted: (_value) {
                setState(() {
                  todoTaskContent = _value;
                });
              },
            ),
          );
        });
  }
}
