// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
    };
