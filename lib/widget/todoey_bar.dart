import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';

class TodoeyBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.list,
              color: Color(0xFF4fc3f7),
              size: 30,
            ),
            backgroundColor: Colors.white,
            radius: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Todoey',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${Provider.of<DataProvider>(context).todos.where((e) => e.scheduledTime.month == DateTime.now().month).toList().length} Tasks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
