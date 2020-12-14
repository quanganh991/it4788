import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class combine_stories_users_models {
  final id_stories;
  final photo_url;
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

  const combine_stories_users_models({
    @required this.id_stories,
    @required this.photo_url,
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

  factory combine_stories_users_models.fromJson(Map<String, dynamic> json) {
    return combine_stories_users_models(
      id_stories: json['id_stories'],
      photo_url: json['photo_url'],
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
