import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class combine_posts_users_models {
  final id_posts;
  final likes_post;
  final comment_post;
  final media_url;
  final shares_post;
  final time_post;
  final title;
  final id_users;

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


  const combine_posts_users_models({
    @required this.id_posts,
    @required this.likes_post,
    @required this.comment_post,
    @required this.media_url,
    @required this.shares_post,
    @required this.time_post,
    @required this.title,
    @required this.id_users,
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

  factory combine_posts_users_models.fromJson(Map<String, dynamic> json) {
    return combine_posts_users_models(
      id_posts: json['id_posts'],
      likes_post: json['likes_post'],
      comment_post: json['comment_post'],
      media_url: json['media_url'],
      shares_post: json['shares_post'],
      time_post: json['time_post'],
      title: json['title'],
      id_users: json['id_users'],
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
