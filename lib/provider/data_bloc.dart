import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/page/add_edit_task_page.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';
import 'package:todoey_flutter_local2/widget/todoey_card.dart';

class DataProvider extends ChangeNotifier {
  TodoeyBlocProvider? todoeyBloc;
  late TabController tabController;
  late int lastDay;

  var addEditFormKey = GlobalKey<FormState>();

  List<Widget> listviewList = [];
  List<Todoey> todos = [];
  bool isLoading = false;

  bool? isEdit;

  String title = '';
  String description = '';
  late Todoey todoey;

  List<TodoeyCard> todoeyCardsBuilder() {
    List<TodoeyCard> dummy = [];

    for (int i = 0; i < lastDay; i++) {
      dummy.add(TodoeyCard(
        data: todos.where((e) => e.scheduledTime == indexDate(i + 1)).toList(),
      ));
    }

    return dummy;
  }

  DateTime indexDate(int day) {
    return DateTime(DateTime.now().year, DateTime.now().month, day);
  }

  titleFieldValidator(String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return "Please enter some text";
    }
    title = newValue;
    notifyListeners();
    return null;
  }

  descriptionFieldValidator(String? newValue) {
    if (newValue == null || newValue.isEmpty) {
      return "Please enter some text";
    }
    description = newValue;
    notifyListeners();
    return null;
  }

  showModal(BuildContext context, bool isEditReceiver, {data, index}) {
    isEdit = isEditReceiver;
    notifyListeners();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddEditTaskPage(
            data: data,
            cardIndex: index,
          ),
        ),
      ),
    );
  }

  updateProgress(int index, bool progress, BuildContext context, data) {
    todoeyBloc!.inUpdateTodoey.add(Todoey(
        id: data[index].id,
        title: data[index].title,
        description: data[index].description,
        progress: progress,
        createdTime: data[index].createdTime,
        scheduledTime: data[index].scheduledTime));
  }

  addTodos(snapshot) {
    todos = snapshot.data!;
  }
}
