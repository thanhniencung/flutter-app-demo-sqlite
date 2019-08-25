import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite/event/delete_todo_event.dart';
import 'package:provider/provider.dart';
import 'todo_bloc.dart';
import 'todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
        stream: bloc.todoListStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              if (snapshot.data == null) {
                return Center(
                  child: Container(
                    child: Text(
                      'Empty!',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(snapshot.data[index].content),
                        trailing: GestureDetector(
                          onTap: () {
                            bloc.event
                                .add(DeleteTodoEvent(snapshot.data[index]));
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red[300],
                          ),
                        ));
                  });
            case ConnectionState.none:
            default:
              return Center(
                  child: Container(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
