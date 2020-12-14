import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class combine_likes_users_model {
  final id_likes;
  final id_users;
  final id_posts;
  final time_like;

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

  const combine_likes_users_model({
    @required this.id_likes,
    @required this.id_users,
    @required this.id_posts,
    @required this.time_like,

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

  factory combine_likes_users_model.fromJson(Map<String, dynamic> json) {
    return combine_likes_users_model(
      id_likes: json['id_likes'],
      id_users: json['id_users'],
      id_posts: json['id_posts'],
      time_like: json['time_like'],
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