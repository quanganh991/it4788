import 'dart:convert';

import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:http/http.dart' as http;



class delete_post {

  static Future<void> DeletePost(String id_posts) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/delete_post/",
      body: {
        'id_posts': id_posts.toString(),
      },
    );

    print("------------id_posts bị xóa = " + id_posts);

    if (response.statusCode == 201) {


    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}