import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';
import 'package:todoey_flutter_local2/widget/todoey_card.dart';

class TabBarViewList extends StatelessWidget {
  TabBarViewList({required this.todoeyCards});

  final List<TodoeyCard> todoeyCards;
  bool? progressTrail = true;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DataProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: p.isLoading ? 0 : 20),
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: p.isLoading
            ? CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )
            : TabBarView(
                controller: p.tabController,
                children: todoeyCards,
              ),
      ),
    );
  }
}
