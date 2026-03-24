import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prem_task/datastore/hiveclass.dart';
class TodoProvider extends ChangeNotifier {
  List<Todo> todos = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
    TextEditingController minutesController = TextEditingController();
      TextEditingController secondsController = TextEditingController();

 final Box<Todo> todoappBox = Hive.box<Todo>('todoappBox');

 
  Timer? timer;

  TodoProvider() {
    startGlobalTimer();
    loadTodoData();
  }

  void loadTodoData() {
    todos = todoappBox.values.toList();
    notifyListeners();
  }

void startGlobalTimer() {
  timer = Timer.periodic(const Duration(seconds: 1), (_) {
    for (var todo in todos) {
      if (todo.isRunning) {
        final remaining = todo.getRemainingSeconds();

        if (remaining <= 0) {
          todo.isRunning = false;

          todo.isCompleted = true;

         
          todo.save();
        }
      }
    }

    notifyListeners();
  });
}

//------Intert Data 
  void addTodo(Todo todo) {
   todoappBox.add(todo); 
    todos = todoappBox.values.toList();
    titleController.clear();
    descriptionController.clear();
    minutesController.clear();
    secondsController.clear();
    notifyListeners();
  }

  void updateTodo(Todo todo, {required String title, required int duration}) {
    todo.title = title;
    todo.duration = duration;
  todo.description = descriptionController.text;
    todo.save(); 
    todos = todoappBox.values.toList();
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    todo.delete();
    todos = todoappBox.values.toList();
    todo.save(); 
    notifyListeners();
  }

  void startTimer(String id) {
    final todo = todos.firstWhere((t) => t.id == id);

    if (!todo.isRunning) {
      todo.startTime = DateTime.now();
      todo.isRunning = true;
      todo.save();
      notifyListeners();
    }
  }

  void pauseTimer(String id) {
    final todo = todos.firstWhere((t) => t.id == id);

    if (todo.isRunning) {
      final remaining = todo.getRemainingSeconds();
      todo.duration = remaining;
      todo.isRunning = false;
      todo.startTime = null;
      todo.save(); 
      notifyListeners();
    }
  }

  void complettimer(String id) {
    final todo = todos.firstWhere((t) => t.id == id);

    todo.isRunning = false;
    todo.startTime = null;
    todo.isCompleted = true;
        todo.save();
    notifyListeners();
  }
}