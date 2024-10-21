import 'package:flutter/material.dart';
import 'package:my_task_list/pages/homepage/screens/home/home_page.dart';

class InstructionManualPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO-DO LIST'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title
          const Text(
            'How the To-do App Works',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Instruction for adding a task
          const ListTile(
            leading: Icon(Icons.add_circle, size: 40, color: Colors.blue),
            title: Text(
              'Add a New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle:
                Text('Tap the "+" button to add a new task to your list.'),
          ),
          const SizedBox(height: 16),

          // Instruction for marking a task as done
          const ListTile(
            leading: Icon(Icons.check_circle, size: 40, color: Colors.green),
            title: Text(
              'Mark Task as Done',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Tap on a task to mark it as completed.'),
          ),
          const SizedBox(height: 16),

          // Instruction for editing a task
          const ListTile(
            leading: Icon(Icons.edit, size: 40, color: Colors.orange),
            title: Text(
              'Edit a Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Tap the edit icon next to any task to modify it.'),
          ),
          const SizedBox(height: 16),

          // Instruction for deleting a task
          const ListTile(
            leading: Icon(Icons.delete, size: 40, color: Colors.red),
            title: Text(
              'Delete a Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Long press a task to delete it'),
          ),
          const SizedBox(height: 24),

          // "Got it" Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Got it!'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
