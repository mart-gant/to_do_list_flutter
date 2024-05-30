import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  TaskData() {
    loadTasks();
  }

  List<Task> get tasks => _tasks;

  int get taskCount => _tasks.length;

  int? get year => null;

  void addTask(String newTaskTitle, String s, DateTime dateTime) {
    final task = Task(title: newTaskTitle, category: '', dueDate: DateTime(year!));
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    saveTasks();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    saveTasks();
    notifyListeners();
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = _tasks.map((task) => json.encode(task.toMap())).toList();
    prefs.setStringList('tasks', tasksJson);
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList('tasks');
    if (tasksJson != null) {
      _tasks = tasksJson.map((taskJson) => Task.fromMap(json.decode(taskJson))).toList();
      notifyListeners();
    }
  }
}
