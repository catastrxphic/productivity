// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Task {
  int id;
  String task;
  Task({
    required this.id,
    required this.task,
  });

  Task copyWith({
    int? id,
    String? task,
  }) {
    return Task(
      id: id ?? this.id,
      task: task ?? this.task,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': task,
    };
  }

  // factory Task.fromMap(Map<String, dynamic> map) {
    
  //   return Task(
  //     id: map['id'],
  //     task: map['task'],
  //   );
  // }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id') || !map.containsKey('task')) {
      throw ArgumentError("Invalid map: 'id' or 'task' key is missing");
    }

    final int? id = map['id'] as int?;
    final String? task = map['task'] as String?;

    if (id == null || task == null) {
      throw ArgumentError("Invalid map: 'id' or 'task' value is null");
    }

    return Task(
      id: id,
      task: task,
    );
  }


  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(id: $id, task: $task)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.task == task;
  }

  @override
  int get hashCode => id.hashCode ^ task.hashCode;
}
