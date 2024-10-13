import 'package:hive_flutter/hive_flutter.dart';

class ClearAllTasks {
  //clear hive

  void clearBox() async {
    var box = await Hive.openBox('tasks');
    box.clear();
    print('cleared');
    print('are you sure cleared');
  }
}
