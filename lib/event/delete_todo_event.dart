import 'package:flutter_app_sqlite/base/base_event.dart';
import 'package:flutter_app_sqlite/todo/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  Todo _todo;

  DeleteTodoEvent(this._todo);

  Todo get todo => _todo;
}
