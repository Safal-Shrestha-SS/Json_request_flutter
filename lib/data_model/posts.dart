import 'package:json_annotation/json_annotation.dart';
part 'posts.g.dart';

@JsonSerializable()
class Posts {
  final int userId;
  final int id;
  final String title;
  final String body;
  Posts(this.userId, this.id, this.title, this.body);
  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);
}
