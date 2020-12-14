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

class post_from_mine_controller{
  static Future<List<users_models>> GetAllUsers(String id_users) async{
    final http.Response response = await http.post("http://"+IP_ADDRESS+"",
      body: {
        'id_users': id_users,
      },
    );

    if (response.statusCode == 201) {
      List<users_models> result = new List<users_models>();

      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString()) ; i++){
        result.add(new users_models(
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],
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
    } else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<void> CreateMyOwnPost(users_models currentUser, String content, String media_url) async{

    print("-------------------id_users = " + currentUser.id_users.toString());

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/add_post/",
      body: {
        'id_users': currentUser.id_users.toString(),
        'title': content,
        'media_url': media_url
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<void> EditMyOwnPost(String id_posts, String content, String media_url) async{
    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/edit_post/",
      body: {
        'id_posts': id_posts,
        'title': content,
        'media_url': media_url
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<List<combine_posts_users_models>> GetAllPostFromAPerson(String id_users) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_list_person_post/",
      body: {
        'id_users': id_users.toString(),
      },
    );


    if (response.statusCode == 201) {
      List<combine_posts_users_models> result = new List<combine_posts_users_models>();

      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString()) ; i++){
        result.add(new combine_posts_users_models(
          id_posts: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_posts'],
          likes_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['likes_post'],
          comment_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['comment_post'],
          media_url: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['media_url'],
          shares_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['shares_post'],
          time_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_post'],
          title: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['title'],

          id_users: jsonDecode((response.body))['data'][i.toString()]['id_users'],
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
    } else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}