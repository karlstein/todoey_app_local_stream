import 'package:date_utils/date_utils.dart' as Utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter_local2/db/todoey_database.dart';
import 'package:todoey_flutter_local2/provider/data_bloc.dart';
import 'package:todoey_flutter_local2/provider/todoey_bloc.dart';
import 'package:todoey_flutter_local2/widget/todoey_stream.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController tabController;
  late int lastDay = Utils.DateUtils.lastDayOfMonth(DateTime.now()).day;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: lastDay,
      vsync: this,
      initialIndex: DateTime.now().day - 1,
    );

    tabController.addListener(() {});

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<DataProvider>(context, listen: false).tabController =
          tabController;

      Provider.of<DataProvider>(context, listen: false).lastDay = lastDay;
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<DataProvider>(context).todoeyBloc =
        context.watch<TodoeyBlocProvider>();
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
          Provider.of<DataProvider>(context, listen: false)
              .showModal(context, false);
        },
        backgroundColor: Color(0xFF4fc3f7),
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: TodoeyStream(),
        ),
      ),
    );
  }
}
