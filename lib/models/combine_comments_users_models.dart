import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class combine_comments_users_models {

  final id_comments;
  final id_users;
  final content_comment;
  final media_comment;
  final time_comment;
  final id_posts;

  final username;
  final password;
  final name;
  final avatar;
  final create_at;
  final push_token;
      final cover_picture;
  final country;
  final city;
  final company;

  const combine_comments_users_models({
    @required this.id_comments,
    @required this.id_users,
    @required this.content_comment,
    @required this.media_comment,
    @required this.time_comment,
    @required this.id_posts,

    @required this.username,
    @required this.password,
    @required this.name,
    @required this.avatar,
    @required this.create_at,
    @required this.push_token,
            @required this.cover_picture,
    @required this.country,
    @required this.city,
    @required this.company,
  });

  factory combine_comments_users_models.fromJson(Map<String, dynamic> json) {
    return combine_comments_users_models(
      id_comments: json['id_comments'],
        id_users: json['id_users'],
        content_comment: json['content_comment'],
      media_comment: json['media_comment'],
        time_comment: json['time_comment'],
        id_posts: json['id_posts'],


      username: json['username'],
        password: json['password'],
        name: json['name'],
      avatar: json['avatar'],
        create_at: json['create_at'],
        push_token: json['push_token'],
country: json['country'],
      company: json['company'],
      city: json['city'],
      cover_picture: json['cover_picture'],
    );
  }
}
