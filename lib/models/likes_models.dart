import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class likes_models {
  final id_likes;
  final id_users;
  final id_posts;
  final time_like;

  const likes_models({
    @required this.id_likes,
    @required this.id_users,
    @required this.id_posts,
    @required this.time_like
  });

  factory likes_models.fromJson(Map<String, dynamic> json) {
    return likes_models(
      id_likes: json['id_likes'],
      id_users: json['id_users'],
      id_posts: json['id_posts'],
      time_like: json['time_like'],
    );
  }
}