import 'package:flutter/material.dart';
import 'package:todofinal/screens/my_drawer.dart';
import 'package:todofinal/widgets/tasks_list.dart';

import '../blocs/bloc_exports.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin_screen';


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
              appBar: AppBar(
                title: Text('Recycle Bin'),
              ),
              drawer:  MyDrawer(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                   Center(
                    child: Chip(
                      label: Text(
                        'Deleted Tasks: ${state.removedTasks.length}',
                      ),
                    ),
                  ),
                  TaskList(tasklist: state.removedTasks)
                ],
              ),
            );
      },
    );
  }
}