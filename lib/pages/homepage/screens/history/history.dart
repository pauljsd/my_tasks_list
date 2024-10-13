import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
             icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Text('History'),
      ),
    );
  }
}
