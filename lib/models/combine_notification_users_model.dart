import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class combine_notification_users_model {
  final id_notifications;
  final contents;
  final readed;
  final id_users_host;
  final id_users_friend;
  final id_posts;
  final time_notifications;
  final username;
  final password;
  final name;
  final avatar;
  final cover_picture;
  final create_at;
  final push_token;
  final country;
  final city;
  final company;
  final likes_post;
  final comment_post;
  final media_url;
  final shares_post;
  final time_post;
  final title;
  final id_users;

  const combine_notification_users_model({
    @required this.id_notifications,
    @required this.contents,
    @required this.readed,
    @required this.id_users_host,
    @required this.id_users_friend,
    @required this.id_posts,
    @required this.time_notifications,
    @required this.username,
    @required this.password,
    @required this.name,
    @required this.avatar,
    @required this.cover_picture,
    @required this.create_at,
    @required this.push_token,
    @required this.country,
    @required this.city,
    @required this.company,
    @required this.likes_post,
    @required this.comment_post,
    @required this.media_url,
    @required this.shares_post,
    @required this.time_post,
    @required this.title,
    @required this.id_users
  });
}