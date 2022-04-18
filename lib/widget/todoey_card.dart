import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/db/todoey_database.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';

class TodoeyCard extends StatelessWidget {
  TodoeyCard({Key? key, required this.data}) : super(key: key);

  final List<Todoey> data;

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DataProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      itemCount: data.isEmpty ? 1 : data.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: data.isEmpty
              ? Text('Task not yet available')
              : Text(
                  data[index].title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      decoration: data[index].progress
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
          subtitle: data.isEmpty
              ? Text('')
              : Text(
                  data[index].description,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      decoration: data[index].progress
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
          trailing: data.isEmpty
              ? Text('')
              : Checkbox(
                  value: data[index].progress,
                  onChanged: (progress) =>
                      Provider.of<DataProvider>(context, listen: false)
                          .updateProgress(index, progress!, context, data),
                ),
          children: [
            data.isEmpty
                ? Text('')
                : Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => p.showModal(context, true,
                              data: data, index: index),
                          icon: Icon(Icons.edit),
                          label: Text('Edit'),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            await TodoeyDatabase.instance
                                .delete(data[index].id!);
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
}
