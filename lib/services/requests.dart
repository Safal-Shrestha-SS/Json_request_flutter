import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_challenges/data_model/comments.dart';
import 'package:intern_challenges/data_model/posts.dart';
import 'package:intern_challenges/data_model/todos.dart';
import 'package:intern_challenges/data_model/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Requests extends ChangeNotifier {
  var commentLength = 0;
  late List<Posts> postsList;
  late List<User> usersList;
  late List<Todos> todos;
  late List<Comments> commentsList;
  Future<List<Posts>> parsePosts(String responseBody) async {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    postsList =
        await parsed.map<Posts>((json) => Posts.fromJson(json)).toList();
    notifyListeners();
    return parsed.map<Posts>((json) => Posts.fromJson(json)).toList();
  }

  List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    usersList = parsed.map<User>((json) => User.fromJson(json)).toList();
    notifyListeners();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  List<Todos> parseTodos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    todos = parsed.map<Todos>((json) => Todos.fromJson(json)).toList();
    notifyListeners();
    return parsed.map<Todos>((json) => Todos.fromJson(json)).toList();
  }

  List<Comments> parseComments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    final test =
        parsed.map<Comments>((json) => Comments.fromJson(json)).toList();
    commentLength = test.length;
    commentsList =
        parsed.map<Comments>((json) => Comments.fromJson(json)).toList();

    notifyListeners();
    return parsed.map<Comments>((json) => Comments.fromJson(json)).toList();
  }

  Future<List<Posts>> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('Post_Key') == null) {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        prefs.setString('Post_Key', response.body);
        return parsePosts(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }
    final give = prefs.getString('Post_Key');
    return parsePosts(give!);
  }

  Future<List<Comments>> fetchComments(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = 'https://jsonplaceholder.typicode.com/posts/$id/comments';

    if (prefs.getString('Comments_Key') == null) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        prefs.setString('Comments_Key', response.body);
        return parseComments(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }
    final give = prefs.getString('Comments_Key');
    return parseComments(give!);
  }

  Future<List<User>> fetchUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('Users_Key') == null) {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        prefs.setString('Users_Key', response.body);
        return parseUsers(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }
    final give = prefs.getString('Users_Key');
    return parseUsers(give!);
  }

  Future<List<Todos>> fetchTodos(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('Todos_Key') == null) {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users/$i/todos'));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        prefs.setString('Todos_Key', response.body);
        return parseTodos(response.body);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }
    final give = prefs.getString('Todos_Key');
    return parseTodos(give!);
  }

  Future<http.Response> postComment(Posts post, User user, String comment) {
    return http.post(
      Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/${post.id}/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'postId': post.id,
        'name': user.name,
        'email': user.email,
        'body': comment
      }),
    );
  }
}
// https://jsonplaceholder.typicode.com/users
// https://jsonplaceholder.typicode.com/posts/{post_id}/comments