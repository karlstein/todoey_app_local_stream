import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/consts.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';
import 'package:todoey_flutter_local2/widget/rounded_button.dart';

class AddEditTaskPage extends StatefulWidget {
  AddEditTaskPage({
    required this.todoeyBloc,
    required this.currentIndex,
    required this.isEdit,
    this.data,
    this.cardIndex,
  });
  final TodoeyBlocProvider todoeyBloc;
  late int currentIndex;
  final bool isEdit;
  late List<Todoey>? data;
  late int? cardIndex;

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  String title = '';
  String description = '';
  late Todoey todoey;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              widget.isEdit ? 'Edit task' : 'Add new task',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autofocus: true,
              initialValue:
                  widget.isEdit ? widget.data![widget.cardIndex!].title : '',
              textAlign: TextAlign.left,
              decoration: kInputDecoration.copyWith(hintText: 'Title'),
              onChanged: (title) {
                setState(() => this.title = title);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.isEdit
                  ? widget.data![widget.cardIndex!].description
                  : '',
              textAlign: TextAlign.left,
              maxLines: 10,
              decoration: kInputDecoration.copyWith(hintText: 'Description'),
              onChanged: (description) {
                setState(() => this.description = description);
              },
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              onPressed: () {
                addOrUpdateTask(this.title, this.description);
                Navigator.pop(context);
              },
              tittle: widget.isEdit ? 'Save' : 'Add',
            )
          ],
        ),
      ),
    );
  }

  void addOrUpdateTask(title, description) {
    if (widget.isEdit) {
      updateTodoey(widget.cardIndex, false, title, description);
    } else {
      addTodoey(title, description);
    }
  }

  void addTodoey(String title, String description) async {
    widget.todoeyBloc.insertTodoey.add(Todoey(
      title: title,
      description: description,
      progress: false,
      createdTime: DateTime.now(),
      scheduledTime: DateTime(
          DateTime.now().year, DateTime.now().month, widget.currentIndex + 1),
    ));
  }

  void updateTodoey(cardIndex, progress, title, description) {
    widget.todoeyBloc.inUpdateTodoey.add(Todoey(
        id: widget.data![cardIndex].id!,
        title: title == '' ? widget.data![cardIndex].title : title,
        description: description == ''
            ? widget.data![cardIndex].description
            : description,
        progress: progress,
        createdTime: widget.data![cardIndex].createdTime,
        scheduledTime: widget.data![cardIndex].scheduledTime));
  }
}
