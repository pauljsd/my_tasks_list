import 'package:flutter/material.dart';

class Annual extends StatelessWidget {
  const Annual({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Annual'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Text('Annual'),
      ),
    );
  }
}
