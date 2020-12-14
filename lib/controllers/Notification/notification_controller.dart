import 'package:fakebook_homepage/models/combine_notification_users_model.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/screens/screens.dart';
import 'package:fakebook_homepage/screens/nav_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class notification_controller {  //lấy post JOIN giữa
  static Future<List<combine_notification_users_model>> GetAllNotification(String id_users) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_notification/",
      body: {
        'id_users': id_users,
      },
    );


    if (response.statusCode == 201) {
      List<combine_notification_users_model> result = new List<combine_notification_users_model>();

      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString()) ; i++){
        result.add(new combine_notification_users_model(
          id_notifications: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_notifications'],
          contents: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['contents'],
          readed: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['readed'],
          id_users_host: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users_host'],
          id_users_friend: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users_friend'],
          id_posts: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_posts'],
          time_notifications: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_notifications'],

          username: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['username'],
          password: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['password'],
          name: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['name'],
          avatar: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['avatar'],
          create_at: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['create_at'],
          push_token: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['push_token'],
          cover_picture: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['cover_picture'],
          country: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['country'],
          city: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['city'],
          company: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['company'],

          likes_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['likes_post'],
          comment_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['comment_post'],
          media_url: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['media_url'],
          shares_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['shares_post'],
          time_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_post'],
          title: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['title'],
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],
        ));
      }


      return result;
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<void> SetReadNotificate(String id_notification) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/set_read_notification/",
      body: {
        'id_notification': id_notification,
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}