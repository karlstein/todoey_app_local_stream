import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/page/task_page.dart';

TaskPage taskPage = TaskPage();

class TabBarList extends StatelessWidget {
  const TabBarList({Key? key, required this.controller, required this.lastDay})
      : super(key: key);
  final TabController controller;
  final int lastDay;

  TabBar tabBarDate() {
    List<Tab> dateList = [];
    for (var i = 0; i < lastDay; i++) {
      dateList.add(Tab(text: (i + 1).toString()));
    }
    return TabBar(
      controller: controller,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF8bf6ff),
      ),
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: dateList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabBarDate();
  }
}
