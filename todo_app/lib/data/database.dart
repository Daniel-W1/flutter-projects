import 'package:hive_flutter/hive_flutter.dart';

class Database {

  final todoBox = Hive.box("myTodo");

  List myTodos = [];
  List completedTodos = [];

  Database() {
    // Retrieve the data from the box
    myTodos = todoBox.get("todos", defaultValue: []);
    completedTodos = todoBox.get("completed", defaultValue: []);
  }

  void updateDB() {
    todoBox.put("todos", myTodos);
    todoBox.put("completed", completedTodos);
  }
}
