import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/db/todoey_database.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';

class TodoeyBlocProvider extends ChangeNotifier {
  final _todoeyController = StreamController<List<Todoey>>.broadcast();

  StreamSink<List<Todoey>> get _inTodoeySink => _todoeyController.sink;

  Stream<List<Todoey>> get getTodoeyStream => _todoeyController.stream;

  final _insertController = StreamController<Todoey>.broadcast();
  final _updateController = StreamController<Todoey>.broadcast();
  final _deleteController = StreamController<int>.broadcast();
  final _searchController = StreamController<String>.broadcast();

  StreamSink<Todoey> get insertTodoey => _insertController.sink;
  StreamSink<Todoey> get inUpdateTodoey => _updateController.sink;
  StreamSink<int> get isDeleteTodoey => _deleteController.sink;
  StreamSink<String> get isSearchTodoey => _searchController.sink;

  TodoeyBlocProvider() {
    updateScreenData();
    _updateController.stream.listen(_handleUpdateTodoey);
    _insertController.stream.listen(_handleAddTodoey);
    _deleteController.stream.listen(_handleDeleteTodoey);
    _searchController.stream.listen(_handleSearchTodoey);
  }

  void _handleAddTodoey(Todoey todoey) async {
    await TodoeyDatabase.instance.create(todoey);
    updateScreenData();
  }

  void _handleUpdateTodoey(Todoey todoey) async {
    await TodoeyDatabase.instance.update(todoey);
    updateScreenData();
  }

  void _handleDeleteTodoey(int id) async {
    await TodoeyDatabase.instance.delete(id);
    updateScreenData();
  }

  void _handleSearchTodoey(String text) async {
    List<Todoey> todoey = await TodoeyDatabase.instance.readAllTodoey();

    var dummyListData = <Todoey>[];

    todoey.forEach((stud) {
      var st2 = Todoey(
        id: stud.id,
        title: stud.title,
        description: stud.description,
        progress: stud.progress,
        createdTime: stud.createdTime,
        scheduledTime: stud.scheduledTime,
      );

      if ((st2.title.toLowerCase().contains(text.toLowerCase()) ||
          st2.description.toLowerCase().contains(text.toLowerCase()))) {
        dummyListData.add(stud);
      }
    });
    _inTodoeySink.add(dummyListData);
  }

  updateScreenData() async {
    List<Todoey> todoey = await TodoeyDatabase.instance.readAllTodoey();

    _inTodoeySink.add(todoey);
  }

  @override
  void dispose() {
    _todoeyController.close;
    _insertController.close;
    _deleteController.close;
    _updateController.close;
    _searchController.close;
    super.dispose();
  }
}
