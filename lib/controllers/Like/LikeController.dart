import 'package:fakebook_homepage/models/combine_likes_users_model.dart';
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

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class LikeController{  //lấy post JOIN giữa
  static Future<IconData> HandleLikeButtonEvent(String id_posts, String id_users) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/like/",
      body: {
        'id_users': id_users,
        'id_posts': id_posts
      },
    );


    if (response.statusCode == 201) {
      return jsonDecode(response.body.toString().replaceAll(new RegExp(r'<br />'), '').toString()
      )['data']['status'].toString() == '1' ? MdiIcons.thumbUp : MdiIcons.thumbUpOutline;  //1 (đã like) thì like và trả về đặc, 0 (bỏ like) thì unlike trả về rỗng
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }

  static Future<IconData> CheckHasBeenLikedPostEvent(String id_posts, String id_users) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/check_has_been_liked_post_event/",
      body: {
        'id_users': id_users.toString(),
        'id_posts': id_posts.toString()
      },
    );


    if (response.statusCode == 201) {
      return jsonDecode(response.body.toString().replaceAll(new RegExp(r'<br />'), '').toString()
      )['data']['liked'].toString() == '1' ? MdiIcons.thumbUpOutline : MdiIcons.thumbUp;  //1 (chưa like) thì like và trả về đặc, 0 (đã like) thì unlike trả về rỗng
      // return MdiIcons.thumbUpOutline;
    } //nếu chưa like thì trả về icon đặc,
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }




  static Future<List<combine_likes_users_model>> GetAllLikesOfAPost(String id_posts) async {
    final http.Response response = await http.post("http://" + IP_ADDRESS + "/api/get_all_like_of_apost/",
      body: {
        'id_posts': id_posts
      },
    );


    if (response.statusCode == 201) {
      print("--------------sizeo = " + json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString());
      List<combine_likes_users_model> result = new List<combine_likes_users_model>();
      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString()) ; i++){
        result.add(new combine_likes_users_model(
          id_likes: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_likes'],
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],
          id_posts: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_posts'],
          time_like: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_like'],

          username: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['username'],
          password: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['password'],
          name: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['name'],
          avatar: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['avatar'],
          create_at: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['create_at'],
          push_token: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['push_token'],
          company: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['company'],
          city: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['city'],
          cover_picture: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['cover_picture'],
          country: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['country'],
        ));
      }
      return result;
      //
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}