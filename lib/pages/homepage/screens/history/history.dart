import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_task_list/pages/homepage/models/task.dart';
import 'package:my_task_list/pages/homepage/screens/history/widgets/historytask.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var historyBox = Hive.box('history');

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, Box box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No history available.'));
          }

          // Get all the keys (dates or integers) from the history box
          List<dynamic> keys = box.keys.toList();

          return ListView.builder(
            // itemCount: dates.length,
            itemCount: keys.length,
            itemBuilder: (context, index) {
              // String date = dates[index];
              var key = keys[index];

              // Convert the key (whether int or String) to a displayable format
              String displayKey = key is int ? key.toString() : key;

              return ListTile(
                title: Text(displayKey), // Display the date
                onTap: () {
                  // When a date is tapped, navigate to the task list for that date
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryTasksPage(date: displayKey),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
