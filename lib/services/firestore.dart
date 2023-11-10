/*

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskTitle': task.title.toString(),
        'taskDesc': task.description.toString(),
        'taskCategory': task.category.toString(),
      },
    );
  }

  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }
}
*/
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return tasks.add(
      {
        'taskTitle': task.title,
        'taskDesc': task.description,
        'taskCategory': task.category.toString(),
        'taskDate': task.date, // Ajout de la date
      },
    );
  }

  Future<void> updateTask(Task task) {
    return tasks.doc(task.id).update(
      {
        'taskTitle': task.title,
        'taskDesc': task.description,
        'taskCategory': task.category.toString(),
        'taskDate': task.date, // Ajout de la date
      },
    );
  }

  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
// ignore: depend_on_referenced_packages

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return tasks.add(
      {
        'taskTitle': task.title,
        'taskDesc': task.description,
        'taskCategory': task.category.toString(),
        'taskDate': task.date,
      },
    );
  }

  Future<void> deleteTask(String taskId) {
    return tasks.doc(taskId).delete();
  }

  Future<void> updateTask(String taskId, Task updatedTask) {
    return tasks.doc(taskId).update({
      'taskTitle': updatedTask.title,
      'taskDesc': updatedTask.description,
      'taskCategory': updatedTask.category.toString(),
      'taskDate': updatedTask.date,
    });
  }

  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }
}
