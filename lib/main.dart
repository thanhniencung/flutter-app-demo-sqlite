import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_sqlite/todo/todo_bloc.dart';
import 'package:flutter_app_sqlite/todo/todo.dart';
import 'package:flutter_app_sqlite/todo/todo_list.dart';
import 'package:flutter_app_sqlite/event/add_todo_event.dart';

import 'db/todo_database.dart';

void main() async {
  await TodoDatabase.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        body: Provider<TodoBloc>.value(
          value: TodoBloc(),
          child: TodoListContainer(),
        ),
      ),
    );
  }
}

class TodoListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          Expanded(child: TodoList()),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var todoBloc = Provider.of<TodoBloc>(context);
    var txtTodoController = TextEditingController();
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: txtTodoController,
            decoration: InputDecoration(
              labelText: 'Add todo',
              hintText: 'Add todo',
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        RaisedButton.icon(
          onPressed: () {
            print("click");
            todoBloc.event.add(AddTodoEvent(txtTodoController.text));
          },
          label: Text('Add'),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
