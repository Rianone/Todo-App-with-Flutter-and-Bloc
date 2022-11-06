import 'package:flutter/material.dart';
import 'package:todofinal/blocs/bloc_exports.dart';
import 'package:todofinal/models/task.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:uuid/uuid.dart';


class TaskTile extends StatefulWidget {
  TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final TextEditingController titleUpdate = TextEditingController();

  final TextEditingController descUpdate = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  final validateTitle = ValidationBuilder().minLength(3).maxLength(20).build();

  final validateDesc = ValidationBuilder().minLength(0).maxLength(30).build();

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
      var snackBarDelete = const SnackBar(content: Text('Task moved to recycle bin'));
      var snackBarMove = const SnackBar(content: Text('Task deleted with success'));
    task.isDeleted!
        ? {ctx.read<TasksBloc>().add(DeleteTask(task: task)),
          ScaffoldMessenger.of(ctx).showSnackBar(snackBarMove)
        }
        : {ctx.read<TasksBloc>().add(RemovedTask(task: task)),
          ScaffoldMessenger.of(ctx).showSnackBar(snackBarDelete)
        };
  }

  void _favoriteOrNoneTask(BuildContext ctx, Task task) {
    task.isFavorite!
        ? null
        : ctx.read<TasksBloc>().add(FavoriteTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    void _submit() {
      if (_form.currentState!.validate()) {
      context.read<TasksBloc>().add(RemovedTask(task: widget.task));
      context.read<TasksBloc>().add(DeleteTask(task: widget.task));
       var task_update = Task(
            title: titleUpdate.text,
            description: descUpdate.text,
            id: Uuid().v4()
        );
      context.read<TasksBloc>().add(AddTask(task: task_update));

      Navigator.pop(context);
      titleUpdate.clear();
      descUpdate.clear();
      }
    }

    void _favorite() {
      if (_form.currentState!.validate()) {
      context.read<TasksBloc>().add(RemovedTask(task: widget.task));
      context.read<TasksBloc>().add(DeleteTask(task: widget.task));
       var task_update = Task(
            title: titleUpdate.text,
            description: descUpdate.text,
            id: Uuid().v4()
        );
      context.read<TasksBloc>().add(FavoriteTask(task: task_update));

      Navigator.pop(context);
      titleUpdate.clear();
      descUpdate.clear();
      }
    }

    return ListTile(
      title: Text(
        widget.task.title,
        style: TextStyle(
            decoration: widget.task.isDone! ? TextDecoration.lineThrough : null,
            fontSize: 23),
      ),
      subtitle: Text(
        "${widget.task.description} : ${DateFormat().add_yMMMd().add_Hms().format(DateTime.now())}",
      ),
      leading: widget.task.isDeleted == false && widget.task.isFavorite == false
          ? Checkbox(
              value: widget.task.isDone,
              onChanged: (value) {
                context.read<TasksBloc>().add(UpdateTask(task: widget.task));
              })
          : null,
      trailing: widget.task.isDeleted! 
      ? GestureDetector(
        child: Icon(Icons.delete, color: Colors.red),
        onTap: () => {_removeOrDeleteTask(context, widget.task)} ,
      )
      :PopupMenuButton(
        itemBuilder: widget.task.isFavorite!
        ? ((context) => [
              PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: () => {_removeOrDeleteTask(context, widget.task)},
                      icon: Icon(Icons.delete, color: Colors.red),
                      label: Text("Delete")
                  )),
              PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Update Task"),
                                    content: Form(
                                      key: _form,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            validator: validateTitle,
                                            autofocus: true,
                                            controller: titleUpdate,
                                            decoration: const InputDecoration(
                                                hintText: "Title"),
                                            // onSubmitted: (_) => _submit(),
                                          ),
                                          TextFormField(
                                            validator: validateDesc,
                                            controller: descUpdate,
                                            decoration: const InputDecoration(
                                                hintText: "Description"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: _favorite,
                                        child: const Text("Submit"),
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(120, 40)),
                                      )
                                    ],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                  );
                                })
                          },
                      icon: Icon(Icons.edit),
                      label: Text("Update"))),
            ])
        :((context) => [
              PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: () => {_removeOrDeleteTask(context, widget.task)},
                      icon: Icon(Icons.delete, color: Colors.red),
                      label: Text("Delete")
                  )),
              PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: () {
                        var snackBar = const SnackBar(
                            content: Text('Task added to favorite'));
                        widget.task.isFavorite == true || widget.task.isDeleted == true
                            ? null
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                        _favoriteOrNoneTask(context, widget.task);
                      },
                      icon: const Icon(Icons.favorite),
                      label: const Text("Favorite"))),
              PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: () => {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Update Task"),
                                    content: Form(
                                      key: _form,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            validator: validateTitle,
                                            autofocus: true,
                                            controller: titleUpdate,
                                            decoration: const InputDecoration(
                                                hintText: "Title"),
                                          ),
                                          TextFormField(
                                            validator: validateDesc,
                                            controller: descUpdate,
                                            decoration: const InputDecoration(
                                                hintText: "Description"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: _submit,
                                        child: const Text("Submit"),
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(120, 40)),
                                      )
                                    ],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                  );
                                })
                          },
                      icon: Icon(Icons.edit),
                      label: Text("Update"))),
            ]),
      ),
    );
  }
}
