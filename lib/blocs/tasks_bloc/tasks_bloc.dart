import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todofinal/blocs/bloc_exports.dart';
import 'package:todofinal/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemovedTask>(_onRemovedTask);
    on<FavoriteTask>(_onFavoriteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> allTasks = List.from(state.allTasks)..remove(task);

    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    emit(TasksState(
        allTasks: allTasks,
        removedTasks: state.removedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
      allTasks: state.allTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
    ));
  }

  void _onRemovedTask(RemovedTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    List<Task> favoriteTasks = List.from(state.favoriteTasks)..remove(task);
    List<Task> removedTasks = List.from(state.removedTasks)
      ..add(task.copyWith(isDeleted: true));

    emit(TasksState(
        allTasks: allTasks,
        removedTasks: removedTasks,
        favoriteTasks: favoriteTasks));
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    List<Task> favoriteTasks = List.from(state.favoriteTasks)
      ..add(task.copyWith(isFavorite: true));

    emit(TasksState(
        allTasks: allTasks,
        removedTasks: state.removedTasks,
        favoriteTasks: favoriteTasks));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
