import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class users_models {
  final id_users;
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

  const users_models({
    @required this.id_users,
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

  });

  factory users_models.fromJson(Map<String, dynamic> json) {
    return users_models(
        id_users: json['id_users'],
        username: json['username'],
        password: json['password'],
        name: json['name'],
        avatar: json['avatar'],
        cover_picture: json['cover_picture'],
        create_at: json['create_at'],
        push_token: json['push_token'],
        country: json['country'],
        city: json['city'],
        company: json['company'],

    );
  }
}