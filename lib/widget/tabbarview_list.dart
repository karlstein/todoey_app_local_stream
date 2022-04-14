import 'package:flutter/material.dart';
import 'package:todoey_flutter_local2/widget/todoey_card.dart';

class TabBarViewList extends StatelessWidget {
  TabBarViewList({
    required this.controller,
    required this.isLoading,
    required this.todoeyCards,
  });

  late TabController controller;
  late bool isLoading;
  final List<TodoeyCard> todoeyCards;
  bool? progressTrail = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isLoading ? 0 : 20),
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: isLoading
            ? CircularProgressIndicator(
                backgroundColor: Colors.grey,
              )
            : TabBarView(
                controller: controller,
                children: todoeyCards,
              ),
      ),
    );
  }
}
