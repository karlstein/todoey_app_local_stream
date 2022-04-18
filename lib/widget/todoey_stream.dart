import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';
import 'package:todoey_flutter_local2/widget/tab_section.dart';
import 'package:todoey_flutter_local2/widget/todoey_bar.dart';

class TodoeyStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DataProvider>(context);
    return StreamBuilder<List<Todoey>>(
      stream: p.todoeyBloc!.getTodoeyStream,
      builder: (BuildContext context, AsyncSnapshot<List<Todoey>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length == 0) {
            return Text("No Data");
          }
          p.addTodos(snapshot);

          return Column(
            children: [
              TodoeyBar(),
              TabSection(),
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
