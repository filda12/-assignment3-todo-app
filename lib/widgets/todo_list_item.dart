import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/models/todo.dart';
import 'package:my_todo_app/themes/theme.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  void updateTodo(BuildContext context, String id) async {
    var response = await Dio().patch(
        "https://todo-mobile-app-backend.herokuapp.com/todo/$id",
        data: {'isCompleted': true});
    return Navigator.of(context).pop(response.data == null);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      secondaryBackground: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.hotPink,
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        todo.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 19,
                            color: AppColors.deepBlue),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.notifications,
                        size: 16,
                        color: AppColors.hotPink,
                      ),
                      Text(
                        todo.time,
                        style: const TextStyle(
                          color: AppColors.hotPink,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          todo.description,
                          style: const TextStyle(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 80),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
      confirmDismiss: (dismissDirection) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
              "Are you sure you want to ${dismissDirection == DismissDirection.startToEnd ? 'update' : 'delete'} this Todo's status?"),
          actions: [
            TextButton(
                onPressed: () async {
                  if (dismissDirection == DismissDirection.startToEnd) {
                    updateTodo(context, todo.id);
                  }
                },
                child: const Text('Ok')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
