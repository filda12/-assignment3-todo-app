import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewTodoPage extends StatelessWidget {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController dateTextEditingController = TextEditingController();
  TextEditingController timeTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a new Todo"),
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: titleTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  prefixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: descriptionTextEditingController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Description",
                  prefixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: dateTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Date",
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.parse("2090-12-31"),
                  );
                  dateTextEditingController.text = selectedDate == null
                      ? ""
                      : "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: timeTextEditingController,
                decoration: const InputDecoration(
                  hintText: "Time",
                  prefixIcon: Icon(Icons.timer),
                ),
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  timeTextEditingController.text = selectedTime == null
                      ? ""
                      : "${selectedTime.hourOfPeriod}: ${selectedTime.minute} ${selectedTime.period.index == 0 ? 'AM' : 'PM'}";
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var data = {
                    "title": timeTextEditingController.text,
                    "description": descriptionTextEditingController.text,
                    "date": dateTextEditingController.text,
                    "time": timeTextEditingController.text,
                    "isCompleted": false,
                  };

                  var response = await Dio().post(
                      "https://todo-mobile-app-backend.herokuapp.com/todo",
                      data: data);
                  print(response.data);
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
