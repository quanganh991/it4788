import 'dart:convert';

import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:http/http.dart' as http;



class block_controller {

  static Future<void> Unblock(String id_user_block, String id_user_be_blocked) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/unblock/",
      body: {
        'id_user_block': id_user_block,
        'id_user_be_blocked': id_user_be_blocked,
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }

  static Future<void> Block(String id_user_block, String id_user_be_blocked) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/set_block/",
      body: {
        'id_user_block': id_user_block,
        'id_user_be_blocked': id_user_be_blocked,
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }

  static Future<List<users_models>> GetAllBlockedUsers(String id_users) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_list_blocks/",
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
}