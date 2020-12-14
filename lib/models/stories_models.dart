import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class stories_models {
  final id_stories;
  final photo_url;
  final id_users;

  const stories_models(
      {@required this.id_stories,
      @required this.photo_url,
      @required this.id_users});

  factory stories_models.fromJson(Map<String, dynamic> json) {
    return stories_models(
      id_stories: json['id_stories'],
      photo_url: json['photo_url'],
      id_users: json['id_users'],
    );
  }
}
