import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class shares_model {
  final id_shares;
  final id_users;
  final id_posts;
  final time_shares;

  const shares_model(
      {@required this.id_shares,
      @required this.id_users,
      @required this.id_posts,
      @required this.time_shares});

  factory shares_model.fromJson(Map<String, dynamic> json) {
    return shares_model(
      id_shares: json['id_shares'],
      id_users: json['id_users'],
      id_posts: json['id_posts'],
      time_shares: json['time_shares'],
    );
  }
}
