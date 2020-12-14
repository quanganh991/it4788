import 'dart:convert';

import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:http/http.dart' as http;



class edit_post {

  static Future<void> SubmitEditPost(String id_posts, String content, String media_url) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/edit_post/",
      body: {
        'title': content,
        'media_url': media_url,
        'id_posts': id_posts,
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}