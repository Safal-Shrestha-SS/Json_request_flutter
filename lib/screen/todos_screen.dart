import 'package:flutter/material.dart';
import 'package:intern_challenges/data_model/todos.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:intern_challenges/services/requests.dart';
import 'package:intern_challenges/state/current_user.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late Future<List<Todos>> todosList;
  Future<List<Todos>> getTodos() async {
    User current = context.read<CurrentUser>().currentUser;
    return await context.read<Requests>().fetchTodos(current.id);
  }

  @override
  void initState() {
    super.initState();

    todosList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            FutureBuilder<Object>(
                future: todosList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DataTable(
                    headingRowHeight: 20,
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Completed')),
                    ],
                    rows: context
                        .watch<Requests>()
                        .todos
                        .map((e) => DataRow(cells: [
                              DataCell(Text(e.title.toString())),
                              DataCell(Text(e.completed.toString())),
                            ]))
                        .toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
