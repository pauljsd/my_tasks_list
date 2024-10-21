import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_task_list/pages/homepage/models/task.dart';
import 'package:intl/intl.dart';

class HistoryTasksPage extends StatefulWidget {
  final String date;

  HistoryTasksPage({required this.date});

  @override
  _HistoryTasksPageState createState() => _HistoryTasksPageState();
}

class _HistoryTasksPageState extends State<HistoryTasksPage> {
  bool showTaskList = true; // To toggle between list and summary view

  @override
  Widget build(BuildContext context) {
    var historyBox = Hive.box('history');
    List tasks = historyBox.get(widget.date, defaultValue: []);

    // Count the completed and pending tasks for the summary
    int completedTasks = tasks.where((task) => Task.fromMap(task).done).length;
    int pendingTasks = tasks.length - completedTasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks for ${widget.date}'),
      ),
      body: Column(
        children: [
          // Add buttons for switching views
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showTaskList = true; // Show task list
                  });
                },
                child: Text('See List of Tasks'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showTaskList = false; // Show task summary
                  });
                },
                child: Text('See Summary of Tasks'),
              ),
            ],
          ),

          // Show either task list or task summary based on the selected view
          Expanded(
            child: showTaskList
                ? _buildTaskList(tasks)
                : _buildTaskSummary(completedTasks, pendingTasks, tasks.length),
          ),
        ],
      ),
    );
  }

  // Function to build task list view
  Widget _buildTaskList(List tasks) {
    return tasks.isEmpty
        ? Center(child: Text('No tasks for this date.'))
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = Task.fromMap(tasks[index]);
              String formattedTime =
                  DateFormat('h:mma').format(task.timestamp).toLowerCase();

              return ListTile(
                title: Text(task.content),
                subtitle: task.done
                    ? Text('Completed around $formattedTime')
                    : Text('Not done'),
              );
            },
          );
  }

  // Function to build task summary view
  Widget _buildTaskSummary(int completed, int pending, int total) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Task Summary for ${widget.date}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Total tasks: $total',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Completed tasks: $completed',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              'Pending tasks: $pending',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
