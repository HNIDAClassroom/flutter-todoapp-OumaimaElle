/*import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onDelete;

  TasksList({required this.tasks, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(
        tasks[index],
        onDelete: () => onDelete(tasks[index]
            .id), // Appeler la fonction onDelete avec l'ID de la tâche
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onDelete;
  final Function(Task) onEdit;

  TasksList(
      {required this.tasks, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(
        tasks[index],
        onDelete: () => onDelete(tasks[index].id),
        onEdit: (updatedTask) => onEdit(updatedTask),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onDelete;
  final Function(Task) onEdit;

  TasksList(
      {required this.tasks, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(
        tasks[index],
        onDelete: () => onDelete(tasks[index].id),
        onEdit: (updatedTask) => onEdit(updatedTask),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/widgets/task_item.dart';
import 'package:todolist_app/widgets/tasks.dart';
//import 'package:todolist_app/widgets/tasks.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(Tasks[index])
    );
  }
}
// Text(tasks[index].title),);
*/  
