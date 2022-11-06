import 'package:flutter/material.dart';
import 'package:todofinal/models/task.dart';
import 'package:todofinal/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasklist,
  }) : super(key: key);

  final List<Task> tasklist;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: tasklist.length,
      itemBuilder: (context, index) {
        var task = tasklist[index];
        return TaskTile(task: task);
      },
    ));
  }
}


