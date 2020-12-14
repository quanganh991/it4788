import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class posts_models {
  final id_posts;
  final likes_post;
  final comment_post;
  final media_url;
  final shares_post;
  final time_post;
  final title;
  final id_users;

  const posts_models(
      {@required this.id_posts,
      @required this.likes_post,
      @required this.comment_post,
      @required this.media_url,
      @required this.shares_post,
      @required this.time_post,
      @required this.title,
      @required this.id_users});

  factory posts_models.fromJson(Map<String, dynamic> json) {
    return posts_models(
      id_posts: json['id_posts'],
      likes_post: json['likes_post'],
      comment_post: json['comment_post'],
      media_url: json['media_url'],
      shares_post: json['shares_post'],
      time_post: json['time_post'],
      title: json['title'],
      id_users: json['id_users'],
    );
  }
}
