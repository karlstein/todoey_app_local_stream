import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';
import 'package:todoey_flutter_local2/widget/tabbar_list.dart';
import 'package:todoey_flutter_local2/widget/tabbarview_list.dart';
import 'package:todoey_flutter_local2/widget/todoey_card.dart';

class TabSection extends StatefulWidget {
  final List<Todoey> data;
  final TodoeyBlocProvider todoeyBloc;
  late TabController controller;
  final int lastDay;

  TabSection({
    required this.controller,
    required this.data,
    required this.todoeyBloc,
    required this.lastDay,
    Key? key,
  }) : super(key: key);

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  bool isLoading = false;

  DateTime indexDate(int day) {
    return DateTime(DateTime.now().year, DateTime.now().month, day);
  }

  List<TodoeyCard> createMonthlyTodoeyCard1() {
    List<TodoeyCard> dummy = [];

    for (int i = 0; i < widget.lastDay; i++) {
      dummy.add(TodoeyCard(
          data: widget.data
              .where((e) => e.scheduledTime == indexDate(i + 1))
              .toList(),
          todoeyBloc: widget.todoeyBloc,
          controller: widget.controller));
    }

    return dummy;
  }

  @override
  void initState() {
    widget.controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: TabBarList(
            controller: widget.controller,
            lastDay: widget.lastDay,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF0093c4),
          ),
        ),
        TabBarViewList(
          controller: widget.controller,
          isLoading: isLoading,
          todoeyCards: createMonthlyTodoeyCard1(),
        ),
      ],
    );
  }
}
