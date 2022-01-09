import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app/models/app_state.dart';
import 'package:my_todo_app/models/todo.dart';
import 'package:my_todo_app/pages/add_new_todo.dart';
import 'package:my_todo_app/themes/theme.dart';
import 'package:my_todo_app/widgets/todo_list_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            CircleAvatar(),
            SizedBox(width: 10),
            Text(
              "My tasks",
              style: TextStyle(
                  color: AppColors.deepBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: AppColors.deepBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.search, color: AppColors.deepBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: Material(
        color: AppColors.bgGrey,
        child: Consumer<AppState>(
          builder: (context, appState, child) => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: appState.allTodos.length,
            itemBuilder: (BuildContext context, int index) {
              Todo todo = appState.allTodos[index];
              return TodoListItem(todo: todo);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.navyBlue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewTodoPage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Builder(builder: (context) {
          return Container(
            height: 60,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container();
                    });
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Completed",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.keyboard_arrow_down),
                  Spacer(),
                  Text(
                    "24",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
