class Task {
  String content;
  DateTime timestamp;
  bool done;

  Task({
    required this.content,
    required this.timestamp,
    required this.done,
  });

  //a factory function to return the map
  factory Task.fromMap(Map task) {
    return Task(
      content: task['content'] ?? 'Untitled Task',
      timestamp: task["timestamp"] != null
          ? DateTime.parse(task['timestamp'])
          : DateTime.now(),
      done: task["done"] ?? false,
    );
  }

//making it a map for easy hive integration
  Map toMap() {
    return {
      "content": content,
      "timestamp": timestamp.toIso8601String(),
      "done": done,
    };
  }
}
