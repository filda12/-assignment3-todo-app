import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_todo_app/models/todo.dart';

class AppState extends ChangeNotifier {
  List<Todo> allTodos = [];

  getAllTodos() async {
    var response =
        await Dio().get("https://todo-mobile-app-backend.herokuapp.com/todos");
    print(response.data);

    allTodos = response.data == null
        ? []
        : List.from(response.data)
            .map((todo) => Todo(
                  id: todo["_id"],
                  title: todo["title"],
                  description: todo["description"],
                  date: todo["date"],
                  time: todo["time"],
                ))
            .toList();
    notifyListeners();
  }

  markAsCompleted(Todo todo) async {
    var response = await Dio().patch(
        "https://todo-mobile-app-backend.herokuapp.com/todo/${todo.id}",
        data: {"isCompleted": true});
    print(response.data);
    await getAllTodos();
    notifyListeners();
  }

  deleteTodo(Todo todo) async {
    var response = await Dio().delete(
        "https://todo-mobile-app-backend.herokuapp.com/todo/${todo.id}");
    print(response.data);
    await getAllTodos();
    notifyListeners();
  }
}
