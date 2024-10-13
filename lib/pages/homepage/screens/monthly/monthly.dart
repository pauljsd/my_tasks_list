import 'package:flutter/material.dart';

class Monthly extends StatelessWidget {
  const Monthly({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Monthly'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
             icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Text('Monthly'),
      ),
    );
  }
}