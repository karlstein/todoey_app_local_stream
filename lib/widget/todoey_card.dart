import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/db/todoey_database.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/page/add_edit_task_page.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';

class TodoeyCard extends StatefulWidget {
  final List<Todoey> data;
  late TabController controller;
  final TodoeyBlocProvider todoeyBloc;

  TodoeyCard({
    Key? key,
    required this.data,
    required this.todoeyBloc,
    required this.controller,
  }) : super(key: key);

  @override
  State<TodoeyCard> createState() => _TodoeyCardState();
}

class _TodoeyCardState extends State<TodoeyCard> {
  late Todoey todoey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      itemCount: widget.data.isEmpty ? 1 : widget.data.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: widget.data.isEmpty
              ? Text('Task not yet available')
              : Text(
                  widget.data[index].title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      decoration: widget.data[index].progress
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
          subtitle: widget.data.isEmpty
              ? Text('')
              : Text(
                  widget.data[index].description,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: widget.data[index].progress
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
          trailing: widget.data.isEmpty
              ? Text('')
              : Checkbox(
                  value: widget.data[index].progress,
                  onChanged: (value) {
                    setState(() {
                      widget.data[index].progress = value!;
                      updateProgress(index, value);
                    });
                  }),
          children: [
            widget.data.isEmpty
                ? Text('')
                : Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: AddEditTaskPage(
                                        todoeyBloc: widget.todoeyBloc,
                                        currentIndex: widget.controller.index,
                                        isEdit: true,
                                        data: widget.data,
                                        cardIndex: index,
                                      ),
                                    ),
                                  )),
                          icon: Icon(Icons.edit),
                          label: Text('Edit'),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            await TodoeyDatabase.instance
                                .delete(widget.data[index].id!);
                          },
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                        ),
                      )
                    ],
                  )
          ],
        );
      },
    );
  }

  void updateProgress(index, value) {
    widget.todoeyBloc.inUpdateTodoey.add(Todoey(
        id: widget.data[index].id,
        title: widget.data[index].title,
        description: widget.data[index].description,
        progress: value,
        createdTime: widget.data[index].createdTime,
        scheduledTime: widget.data[index].scheduledTime));
  }
}
