// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intern_challenges/data_model/comments.dart';
import 'package:intern_challenges/data_model/posts.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:intern_challenges/screen_body/topbar.dart';
import 'package:intern_challenges/services/requests.dart';
import 'package:intern_challenges/state/current_user.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final List<Comments> commentsList;
  final Posts post;
  final User user;

  const CommentScreen(
      {required this.commentsList, required this.post, required this.user});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final requests = Requests();
  final myController = TextEditingController();
  final snackBar = SnackBar(
    content: const Text("Comment Posted but doesn't persist"),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  late String comment;
  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Card(
                  child: Column(
                children: [
                  ListTile(
                    dense: true,
                    title: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.user.name,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                          TextSpan(
                            text: ' @${widget.user.username}',
                            style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          )
                        ],
                      ),
                    ),
                    subtitle: ListTile(
                      title: Text(widget.post.title),
                      subtitle: Text(
                        widget.post.body,
                      ),
                      contentPadding: const EdgeInsetsDirectional.all(0),
                    ),
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const IconButton(
                          onPressed: null, icon: Icon(Icons.comment)),
                      Text(widget.commentsList.length.toString())
                    ],
                  ),
                ],
              )),
              Divider(
                endIndent: 15,
                indent: 15,
                thickness: 5,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.commentsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.commentsList[index].email,
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontWeightDelta: 50),
                                ),
                              ],
                            ),
                          ),
                          subtitle: ListTile(
                            title: Text(widget.commentsList[index].name),
                            subtitle: Text(
                              widget.commentsList[index].body,
                            ),
                            contentPadding: const EdgeInsetsDirectional.all(0),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: (Theme.of(context).bottomAppBarColor),
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: myController,
                        onChanged: (value) {
                          comment = value;
                        },
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(
                                decorationStyle: TextDecorationStyle.wavy),
                            border: InputBorder.none,
                            hintText: '  Comment...'),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (myController.text.isNotEmpty) {
                            try {
                              await requests.postComment(
                                  widget.post,
                                  context.read<CurrentUser>().currentUser,
                                  comment);
                              comment = '';
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } catch (e) {
                              throw Exception("Couldn't upload");
                            }
                          }
                          myController.clear();
                        },
                        child: const Text('Post'))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
