import 'dart:async';
import 'package:flutter_app_sqlite/base/base_bloc.dart';
import 'package:flutter_app_sqlite/db/todo_table.dart';
import 'package:flutter_app_sqlite/event/delete_todo_event.dart';
import 'package:flutter_app_sqlite/todo/todo.dart';
import 'dart:math';
import 'package:flutter_app_sqlite/event/add_todo_event.dart';

class TodoBloc extends BaseBloc {
  TodoTable _todoTable = TodoTable();
  var _randomInt = new Random();
  List<Todo> _todoListData = List<Todo>();

  StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();
  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if (_todoListData == null) {
      print("AHHIHIHI");
      return;
    }
    print("Ahhoho");
    _todoListStreamController.sink.add(_todoListData);
  }

  _addTodo(String content) async {
    Todo todo = Todo.fromData(
      _randomInt.nextInt(1000000),
      content,
    );

    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);

    _todoListData.remove(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  @override
  dispatchEvent(event) {
    if (event is AddTodoEvent) {
      _addTodo(event.content);
    } else if (event is DeleteTodoEvent) {
      _deleteTodo(event.todo);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
