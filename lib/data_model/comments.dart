import 'package:json_annotation/json_annotation.dart';
part 'comments.g.dart';

@JsonSerializable()
class Comments {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comments(this.postId, this.id, this.name, this.email, this.body);
  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
