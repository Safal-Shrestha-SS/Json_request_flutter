import 'package:flutter/material.dart';
import 'package:intern_challenges/data_model/comments.dart';
import 'package:intern_challenges/data_model/posts.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:intern_challenges/screen/comment_screen.dart';
import 'package:intern_challenges/screen_body/topbar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Container(
          color: Theme.of(context).backgroundColor,
          child: FutureBuilder<List<Posts>>(
              future: context.read<Requests>().postsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return PostBox(items: snapshot.data, users: usersList);
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
  Future<List<Comments>> getComments(String id) async {
    List<Comments> commentsList;

    commentsList = await context.read<Requests>().fetchComments(id);
    return commentsList;
  }

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
                            user: widget.users![id],
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
                                text: widget.users![id].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' @${widget.users![id].username}',
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
                            future:
                                getComments(widget.items![index].id.toString()),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              send = snapshot.data!;
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
