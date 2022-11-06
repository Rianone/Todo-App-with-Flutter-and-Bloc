import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:form_validator/form_validator.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final validateTitle = ValidationBuilder().minLength(3).maxLength(20).build();

  final validateDesc = ValidationBuilder().minLength(0).maxLength(30).build();


  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Form(
      key: _form,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 2000),
          child: Column(
            children: [
              const Text(
                "Add Task",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: validateTitle,
                autofocus: true,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(15)),
              TextFormField(
                validator: validateDesc,
                controller: descController,
                decoration: const InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                        var task = Task(
                            title: titleController.text,
                            description: descController.text,
                            id: Uuid().v4());
                        context.read<TasksBloc>().add(AddTask(task: task));
                        Navigator.pop(context);
                        } 
                      },
                      child: const Text("Add")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
