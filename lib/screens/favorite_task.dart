import 'package:flutter/material.dart';
import 'package:todofinal/screens/my_drawer.dart';
import 'package:todofinal/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';

class FavoriteTasks extends StatelessWidget {
  const FavoriteTasks({super.key});
  static const id = 'favorite_task_screen';


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
              appBar: AppBar(
                title: const Text('Favorite Tasks'),
              ),
              drawer:  MyDrawer(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                   Center(
                    child: Chip(
                      label: Text(
                        'Favorite Tasks: ${state.favoriteTasks.length}',
                      ),
                    ),
                  ),
                  TaskList(tasklist: state.favoriteTasks)
                ],
              ),
            );
      },
    );
  }
}