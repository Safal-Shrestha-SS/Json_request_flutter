import 'package:json_annotation/json_annotation.dart';

part 'todos.g.dart';

@JsonSerializable()
class Todos {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todos(this.userId, this.id, this.title, this.completed);
  factory Todos.fromJson(Map<String, dynamic> json) => _$TodosFromJson(json);
  Map<String, dynamic> toJson() => _$TodosToJson(this);
}
