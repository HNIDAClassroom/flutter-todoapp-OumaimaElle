// ignore_for_file: prefer_const_constructors
/*
import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddTask(Task(title: _titleController.text, description: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            //onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task title',
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: _submitTaskData,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({
    Key? key,
    required this.onAddTask,
    required this.initialTask,
    required this.onEditTask,
  });

  final void Function(Task task) onAddTask;
  final void Function(Task task) onEditTask;
  final Task initialTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late Category _selectedCategory;
  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedCategory = Category.personal; // Default category
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      date: _selectedDate,
      id: '',
    );
    widget.onAddTask(newTask);
    // Clear controllers after adding task
    _titleController.clear();
    _descriptionController.clear();
    // Reset category and date to defaults
    _selectedCategory = Category.personal;
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 100,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
          DropdownButton<Category>(
            value: _selectedCategory,
            onChanged: (Category? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue;
                });
              }
            },
            items: Category.values
                .map<DropdownMenuItem<Category>>(
                  (Category value) => DropdownMenuItem<Category>(
                    value: value,
                    child: Text(value.toString().split('.').last),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Choisir une date'),
          ),
          Text(
              'Date sélectionnée: ${DateFormat('dd-MM-yyyy').format(_selectedDate)}'),
          Row(
            children: [
              ElevatedButton(
                onPressed: _submitTaskData,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
