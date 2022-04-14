import 'package:date_utils/date_utils.dart' as Utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/db/todoey_database.dart';
import 'package:todoey_flutter_local2/model/todoey_model.dart';
import 'package:todoey_flutter_local2/page/add_edit_task_page.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';
import 'package:todoey_flutter_local2/widget/todoey_stream.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> listviewList = [];
  List<Todoey> todos = [];
  bool isLoading = false;
  DateTime lastDayDT = Utils.DateUtils.lastDayOfMonth(DateTime.now());
  late int lastDay = lastDayDT.day;

  TodoeyBlocProvider? todoeyBloc;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: lastDay,
      vsync: this,
      initialIndex: DateTime.now().day - 1,
    );

    // refreshTodos(_tabController.index);
  }

  @override
  void didChangeDependencies() {
    todoeyBloc = context.watch<TodoeyBlocProvider>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    TodoeyDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4fc3f7),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddEditTaskPage(
                  todoeyBloc: todoeyBloc!,
                  currentIndex: _tabController.index,
                  isEdit: false,
                ),
              ),
            ),
          );
        },
        backgroundColor: Color(0xFF4fc3f7),
        child: Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: TodoeyStream(
          controller: _tabController,
          lastDay: lastDay,
        ),
      ),
    );
  }
}
