import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';
import 'package:todoey_flutter_local2/widget/tabbar_list.dart';
import 'package:todoey_flutter_local2/widget/tabbarview_list.dart';

class TabSection extends StatelessWidget {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DataProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: TabBarList(),
          decoration: BoxDecoration(
            color: Color(0xFF0093c4),
          ),
        ),
        TabBarViewList(
          todoeyCards: p.todoeyCardsBuilder(),
        ),
      ],
    );
  }
}
