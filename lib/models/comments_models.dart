import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class comments_models {
  final id_comments;
  final id_users;
  final content_comments;
  final media_comment;
  final time_comment;
  final id_posts;

  const comments_models({
    @required this.id_comments,
    @required this.id_users,
    @required this.content_comments,
    @required this.media_comment,
    @required this.time_comment,
    @required this.id_posts,
  });

  factory comments_models.fromJson(Map<String, dynamic> json) {
    return comments_models(
        id_comments: json['id_comments'],
        id_users: json['id_users'],
        content_comments: json['content_comments'],
        media_comment: json['media_comment'],
        time_comment: json['time_comment'],
        id_posts: json['id_posts']
    );
  }
}