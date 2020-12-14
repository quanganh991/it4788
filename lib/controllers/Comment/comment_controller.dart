import 'dart:convert';

import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:http/http.dart' as http;



class comment_controller {
  static Future<List<combine_comments_users_models>> GetAllCommentsOfAPost(String id_posts) async {
    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_comment/",
      body: {
        'id_posts': id_posts
      },
    );

    if (response.statusCode == 201) {
      List<combine_comments_users_models> result = new List<combine_comments_users_models>();
      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString()) ; i++){
        result.add(new combine_comments_users_models(
          id_comments: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_comments'],
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],
          content_comment: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['content_comment'],
          media_comment: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['media_comment'],
          time_comment: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_comment'],
          id_posts: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_posts'],
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
      throw Exception(
          'Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<void> CreateComment(String content_comment,String media_comment, combine_posts_users_models posts , users_models currentUser) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/set_comment/",
      body: {
        'media_comment': media_comment.toString(),
        'content_comment': content_comment.toString(),
        'id_posts': posts.id_posts.toString(),
        'id_users': currentUser.id_users.toString(),
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}