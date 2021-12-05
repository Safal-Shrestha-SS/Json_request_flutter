import 'package:flutter/material.dart';
import 'package:intern_challenges/data_model/comments.dart';
import 'package:intern_challenges/data_model/posts.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:intern_challenges/screen/comment_screen.dart';

import 'package:intern_challenges/services/requests.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<List<Posts>> postsList;
  List<User>? usersList;
  Future<List<Posts>> getPost() async {
    await context.read<Requests>().fetchPosts();
    await context.read<Requests>().fetchUsers();
    return context.read<Requests>().postsList;
  }

  @override
  void initState() {
    super.initState();

    postsList = getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Theme.of(context).backgroundColor,
          child: FutureBuilder<List<Posts>>(
              future: postsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return PostBox(
                    items: snapshot.data,
                    users: context.watch<Requests>().usersList,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}

class PostBox extends StatefulWidget {
  final List<Posts>? items;
  final List<User>? users;
  // ignore: use_key_in_widget_constructors
  const PostBox({required this.items, required this.users});

  @override
  State<PostBox> createState() => _PostBoxState();
}

class _PostBoxState extends State<PostBox> {
  late List<Comments> send;
  late Posts sendPost;
  late User sendUsers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.items!.length,
        itemBuilder: (context, index) {
          int id = widget.items![index].userId;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommentScreen(
                            commentsList: send,
                            post: widget.items![index],
                            user: (id < 11)
                                ? widget.users![id]
                                : widget.users![2],
                          )));
            },
            child: Hero(
              tag: widget.items![index].id,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: (id < 11)
                                    ? widget.users![id].name
                                    : widget.users![2].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: (id < 11)
                                    ? widget.users![id].username
                                    : ' @${widget.users![2].username}',
                                style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ),
                      subtitle: ListTile(
                        title: Text(widget.items![index].title),
                        subtitle: Text(
                          widget.items![index].body,
                        ),
                        contentPadding: const EdgeInsetsDirectional.all(0),
                      ),
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const IconButton(
                            onPressed: null, icon: Icon(Icons.comment)),
                        FutureBuilder<List<Comments>>(
                            future: context.read<Requests>().fetchComments(
                                widget.items![index].id.toString()),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              send = context.watch<Requests>().commentsList;
                              var length = snapshot.data!.length.toString();

                              return Text(length.toString());
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
