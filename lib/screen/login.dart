import 'package:flutter/material.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:intern_challenges/screen/post_screen.dart';
import 'package:intern_challenges/services/requests.dart';
import 'package:intern_challenges/state/current_user.dart';
import 'package:provider/provider.dart';

final requests = Requests();

class LogIN extends StatefulWidget {
  const LogIN({Key? key}) : super(key: key);

  @override
  _LogINState createState() => _LogINState();
}

class _LogINState extends State<LogIN> {
  late Future<List<User>> userList;
  late List<User> user;
  Future<List<User>> getUser() async {
    user = await requests.fetchUsers();
    return user;
  }

  final snackBar = const SnackBar(content: Text("User doesn't exist"));

  late int userId;
  Future<bool> check(int id) async {
    for (int i = 0; i < user.length; i++) {
      if (user[i].id == id) {
        await context.read<CurrentUser>().loadFromPrefs(user[i]);
        // print(context.read<CurrentUser>().currentUser.id);
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    userList = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  userId = int.parse(value);
                },
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                    border: InputBorder.none,
                    hintText: ' Enter your ID'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (await check(userId)) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
