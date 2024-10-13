import 'package:flutter/material.dart';
import 'package:my_task_list/pages/homepage/screens/annual/annual.dart';
import 'package:my_task_list/pages/homepage/screens/history/history.dart';
import 'package:my_task_list/pages/homepage/screens/monthly/monthly.dart';
import 'package:my_task_list/pages/homepage/screens/weekly/weekly.dart';

class Hamburger extends StatelessWidget {
  const Hamburger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.blue,
      icon: const Icon(Icons.menu), // Hamburger icon
      itemBuilder: (context) => [
        const PopupMenuItem<int>(
          value: 0,
          child: Text("History"),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text("Weekly Goals"),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text("Monthly Goals"),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: Text("Annual Goal"),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 0:
            // Navigate to Option 1
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      History()), // Replace with your destination widget
            );
            break;
          case 1:
            // Navigate to Option 2
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Weekly()), // Replace with your destination widget
            );
            break;
          case 2:
            // Navigate to Option 3
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Monthly()), // Replace with your destination widget
            );
            break;
          case 3:
            // Navigate to Option 3
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Annual()), // Replace with your destination widget
            );
            break;
        }
      },
    );
  }
}
