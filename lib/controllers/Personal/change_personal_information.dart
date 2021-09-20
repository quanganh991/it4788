import 'dart:convert';

import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:http/http.dart' as http;



class change_personal_information {

  static Future<void> ChangePersonalInformation(String id_users, String username, String password, String push_token, String name,String create_at, String country, String city, String company, String avatar, String cover_picture) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/change_info_after_signup/",
      body: {
        'id_users': id_users,
        'username': username,
        'password': password,
        'name': name,
        'push_token': push_token,
        'create_at': create_at,
        'push_token': push_token,
        'country': country,
        'city': city,
        'company': company,
        'avatar': avatar,
        'cover_picture': cover_picture,

      },
    );

    print("-------------Thay đổi thông tin cá nhân: " +  response.body.toString());

    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}