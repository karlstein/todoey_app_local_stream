import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';
import 'package:todoey_flutter_local2/widget/tab_section.dart';
import 'package:todoey_flutter_local2/widget/todoey_bar.dart';
import 'package:todoey_flutter_local2/widget/todoey_card.dart';

class TodoeyStream extends StatefulWidget {
  late TabController controller;
  final int lastDay;

  TodoeyStream({
    Key? key,
    required this.controller,
    required this.lastDay,
  }) : super(key: key);

  @override
  State<TodoeyStream> createState() => _TodoeyStreamState();
}

class _TodoeyStreamState extends State<TodoeyStream> {
  late TodoeyBlocProvider todoeyBloc;
  List<TodoeyCard> listViewList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    todoeyBloc = context.watch<TodoeyBlocProvider>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todoey>>(
      stream: todoeyBloc.getTodoeyStream,
      builder: (BuildContext context, AsyncSnapshot<List<Todoey>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length == 0) {
            return Text("No Data");
          }
          return Column(
            children: [
              TodoeyBar(
                data: snapshot.data!,
              ),
              TabSection(
                controller: widget.controller,
                data: snapshot.data!,
                todoeyBloc: todoeyBloc,
                lastDay: widget.lastDay,
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
