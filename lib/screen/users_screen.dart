import 'package:flutter/material.dart';
import 'package:intern_challenges/services/requests.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // late Future<List<User>> userList;
  // Future<List<User>> getUser() async {
  //   return await context.read<Requests>().fetchUsers();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   userList = getUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        Expanded(
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 4.0,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            constrained: false,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Username')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Address')),
                DataColumn(label: Text('Company')),
              ],
              rows: context
                  .watch<Requests>()
                  .usersList
                  .map((e) => DataRow(cells: [
                        DataCell(Text(e.name.toString())),
                        DataCell(Text(e.username.toString())),
                        DataCell(Text(e.phone.toString())),
                        DataCell(Text(e.email.toString())),
                        DataCell(Text(e.address.city.toString())),
                        DataCell(Text(e.company.name.toString())),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
