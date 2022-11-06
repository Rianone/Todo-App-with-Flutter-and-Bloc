part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  final List<Task> removedTasks;
  final List<Task> favoriteTasks;

  const TasksState({this.allTasks = const <Task>[], this.removedTasks = const <Task>[], this.favoriteTasks = const <Task>[]});

  @override
  List<Object> get props => [allTasks, removedTasks, favoriteTasks];

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((e) => e.toMap()).toList(),
      'removedTasks': removedTasks.map((e) => e.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((e) => e.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        allTasks:
            List<Task>.from(map['allTasks']?.map((x) => Task.fromMap(x))),
        removedTasks:
            List<Task>.from(map['removedTasks']?.map((x) => Task.fromMap(x))),
        favoriteTasks:
            List<Task>.from(map['favoriteTasks']?.map((x) => Task.fromMap(x)))
    );
  }
}
