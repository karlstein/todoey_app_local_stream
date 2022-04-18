import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/consts.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';
import 'package:todoey_flutter_local2/widget/rounded_button.dart';

class AddEditTaskPage extends StatelessWidget {
  AddEditTaskPage({
    this.data,
    this.cardIndex,
  });
  late List<Todoey>? data;
  late int? cardIndex;
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DataProvider>(context);
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: p.addEditFormKey,
          child: Column(
            children: [
              Text(
                p.isEdit! ? 'Edit task' : 'Add new task',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: true,
                initialValue: p.isEdit! ? data![cardIndex!].title : '',
                textAlign: TextAlign.left,
                decoration: kInputDecoration.copyWith(hintText: 'Title'),
                validator: (title) => p.titleFieldValidator(title),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: p.isEdit! ? data![cardIndex!].description : '',
                textAlign: TextAlign.left,
                maxLines: 10,
                decoration: kInputDecoration.copyWith(hintText: 'Description'),
                validator: (description) =>
                    p.descriptionFieldValidator(description),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                onPressed: () {
                  addOrUpdateTask(context, p.title, p.description);
                  Navigator.pop(context);
                },
                tittle: p.isEdit! ? 'Save' : 'Add',
              )
            ],
          ),
        ),
      ),
    );
  }

  void addOrUpdateTask(context, title, description) {
    var p = Provider.of<DataProvider>(context, listen: false);
    if (p.addEditFormKey.currentState!.validate()) {
      if (p.isEdit!) {
        updateTodoey(context);
      } else {
        addTodoey(context);
      }
    }
  }

  void addTodoey(BuildContext context) async {
    var p = Provider.of<DataProvider>(context, listen: false);
    p.todoeyBloc!.insertTodoey.add(Todoey(
      title: p.title,
      description: p.description,
      progress: false,
      createdTime: DateTime.now(),
      scheduledTime: DateTime(
          DateTime.now().year, DateTime.now().month, p.tabController.index + 1),
    ));
    print("${p.title} && ${p.description}");
  }

  void updateTodoey(BuildContext context) {
    var p = Provider.of<DataProvider>(context, listen: false);
    p.todoeyBloc!.inUpdateTodoey.add(Todoey(
        id: data![cardIndex!].id!,
        title: p.title,
        description: p.description,
        progress: false,
        createdTime: data![cardIndex!].createdTime,
        scheduledTime: data![cardIndex!].scheduledTime));
  }
}
