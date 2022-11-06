import 'package:flutter/material.dart';
import 'package:todofinal/blocs/bloc_exports.dart';
import 'package:todofinal/screens/favorite_task.dart';
import 'package:todofinal/screens/recycle_bin.dart';
import 'package:todofinal/screens/tasks_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text("Task Menu",
                  style: Theme.of(context).textTheme.headline5),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: (() => Navigator.of(context)
                      .pushReplacementNamed(TasksScreen.id)),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special),
                    title: const Text("My Tasks"),
                    trailing: Text('${state.allTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: (() => Navigator.of(context)
                      .pushReplacementNamed(RecycleBin.id)),
                  child: ListTile(
                    leading: const Icon(Icons.folder_delete),
                    title: const Text("Recycle Bin"),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: (() => Navigator.of(context)
                      .pushReplacementNamed(FavoriteTasks.id)),
                  child: ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text("Favorite Tasks"),
                    trailing: Text('${state.favoriteTasks.length}'),
                  ),
                );
              },
            ),
            
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                  value: state.switchValue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
