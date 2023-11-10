/*
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/widgets/tasks_list.dart';

class Tasks extendefulWidget {
  const Tasks({Key? key}) : super(key:var 
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();

  final List<Task> _registeredTasks = [
    Task(
      title: 'Apprendre Flutter',
      description: 'Suivre le cours pour apprendre de nouvelles compétences',
      date: DateTime.now(),
      category: Category.work,
    ),
    Task(
      title: 'Faire les courses',
      description: 'Acheter des provisions pour la semaine',
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.shopping,
    ),
    Task(
      title: 'Rediger un CR',
      description: '',
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: Category.personal,
    ),
    // Add more tasks with descriptions as needed
  ];

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
      // firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: TasksList(tasks: _registeredTasks),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/widgets/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();

  final List<Task> _registeredTasks = [
    Task(
      title: 'Apprendre Flutter',
      description: 'Suivre le cours pour apprendre de nouvelles compétences',
      date: DateTime.now(),
      category: Category.work,
      id: '1',
    ),
    Task(
      title: 'Faire les courses',
      description: 'Acheter des provisions pour la semaine',
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.shopping,
      id: '2',
    ),
    Task(
      title: 'Rediger un CR',
      description: '',
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: Category.personal,
      id: '3',
    ),
    // Ajoutez plus de tâches avec des descriptions si nécessaire
  ];

  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(
        onAddTask: _addTask,
        initialTask: Task(
          title: '',
          description: '',
          category: Category.personal,
          date: DateTime.now(),
          id: '',
        ),
        onEditTask: (updatedTask) {
          _editTask(updatedTask);
        },
      ),
    );
  }

  void fetchTasks() {
    firestoreService.getTasks().listen((QuerySnapshot<Object?> taskList) {
      if (taskList.docs.isNotEmpty) {
        List<Task> convertedTasks = taskList.docs
            .map((doc) => Task(
                id: doc.id,
                title: doc['taskTitle'],
                description: doc['taskDesc'],
                date: doc['taskDate'].toDate(),
                category: getCategoryFromString(doc['taskCategory'])))
            .toList();
        setState(() {
          _registeredTasks.addAll(convertedTasks);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
      // firestoreService.addTask(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      _registeredTasks.removeWhere((task) => task.id == taskId);
    });
  }

  /*void _editTask(Task updatedTask) {
    setState(() {
      int index =
          _registeredTasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        _registeredTasks[index] = updatedTask;
        firestoreService.updateTask(updatedTask.id, updatedTask);
      }
    });
  }
  */
  void _editTask(Task updatedTask) {
    print('Updating task with ID: ${updatedTask.id}');
    setState(() {
      int index =
          _registeredTasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        print('Old task: ${_registeredTasks[index].toString()}');
        print('New task: ${updatedTask.toString()}');
        _registeredTasks[index] = updatedTask;
        firestoreService.updateTask(updatedTask.id, updatedTask);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: TasksList(
        tasks: _registeredTasks,
        onDelete: _deleteTask,
        onEdit: (updatedTask) {
          _editTask(updatedTask);
        },
      ),
    );
  }

  Category getCategoryFromString(String category) {
    switch (category) {
      case 'personal':
        return Category.personal;
      case 'work':
        return Category.work;
      case 'shopping':
        return Category.shopping;
      case 'others':
        return Category.others;
      default:
        throw Exception('Invalid category');
    }
  }
}

/*
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/widgets/tasks_list.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService = FirestoreService();
  late List<Task> _registeredTasks;

  @override
  void initState() {
    super.initState();
    _registeredTasks = [];
    fetchTasks();
  }

  void fetchTasks() {
    firestoreService.getTasks().listen((taskList) {
      setState(() {
        _registeredTasks = taskList as List<Task>;
      });
    });
  }

  // Le reste de votre implémentation pour _openAddTaskOverlay, _addTask, _deleteTask, _editTask
  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(
        onAddTask: _addTask,
        initialTask: Task(
          title: '',
          description: '',
          category: Category.personal,
          date: DateTime.now(),
          id: '',
        ),
        onEditTask: (updatedTask) {
          _editTask(updatedTask);
        },
      ),
    );
  }

  void _addTask(Task task) {
    setState(() {
      _registeredTasks.add(task);
      // firestoreService.addTask(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      _registeredTasks.removeWhere((task) => task.id == taskId);
    });
  }

  void _editTask(Task updatedTask) {
    setState(() {
      int index =
          _registeredTasks.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        _registeredTasks[index] = updatedTask;
        firestoreService.updateTask(updatedTask.id, updatedTask);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoList'),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: TasksList(
        tasks: _registeredTasks,
        onDelete: _deleteTask,
        onEdit: (updatedTask) {
          _editTask(updatedTask);
        },
      ),
    );
  }
}
*/