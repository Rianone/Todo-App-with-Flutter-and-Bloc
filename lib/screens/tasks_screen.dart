import 'package:flutter/material.dart';
import 'package:todofinal/screens/add_task_screen.dart';
import 'package:todofinal/screens/my_drawer.dart';
import 'package:todofinal/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Number of Tasks: ${state.allTasks.length}',
                  ),
                ),
              ),
              TaskList(tasklist: tasksList)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
