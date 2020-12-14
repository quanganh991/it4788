import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class recent_searched {
  final id_searchs;
  final keyword;
  final time_search;
  final id_users;

  const recent_searched(
      {@required this.id_searchs,
        @required this.keyword,
        @required this.time_search,
        @required this.id_users,});

  factory recent_searched.fromJson(Map<String, dynamic> json) {
    return recent_searched(
      id_searchs: json['id_searchs'],
      keyword: json['keyword'],
      time_search: json['time_search'],
      id_users: json['id_users'],
    );
  }
}
