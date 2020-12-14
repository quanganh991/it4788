import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class notification_model {
  final id_notifications;
  final contents;
  final readed;
  final id_users_host;
  final id_users_friend;
  final id_posts;
  final time_notifications;

  const notification_model({
    @required this.id_notifications,
    @required this.contents,
    @required this.readed,
    @required this.id_users_host,
    @required this.id_users_friend,
    @required this.id_posts,
    @required this.time_notifications
  });
}