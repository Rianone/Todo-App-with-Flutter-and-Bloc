import 'package:flutter/material.dart';
import 'package:todofinal/screens/favorite_task.dart';
import 'package:todofinal/screens/recycle_bin.dart';
import 'package:todofinal/screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      case TasksScreen.id:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
      case FavoriteTasks.id:
        return MaterialPageRoute(builder: (_) => const FavoriteTasks());
      default:
        return null;
    }
  }
}
