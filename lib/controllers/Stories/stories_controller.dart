import 'package:fakebook_homepage/models/combine_stories_users_models.dart';
import 'package:fakebook_homepage/models/combine_stories_users_models.dart';
import 'package:fakebook_homepage/models/combine_stories_users_models.dart';
import 'package:fakebook_homepage/models/combine_stories_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class stories_controller{
  static Future<List<combine_stories_users_models>> GetAllStories(String id_users) async{
    final http.Response response = await http.post("http://"+IP_ADDRESS+"/",
      body: {
        'id_users': id_users,
      },
    );

    print('-----------------------response.statusCode = ' + response.statusCode.toString());

    if (response.statusCode == 201) {

      List<combine_stories_users_models> result = new List<combine_stories_users_models>();
      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']['num_rows'].toString()) ; i++){
        result.add(new combine_stories_users_models(
          id_stories: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_stories'],
          photo_url: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['photo_url'],
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],

          username : json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['username'],
          password : json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['password'],
          name : json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['name'],
          avatar : json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['avatar'],
          create_at : json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['create_at'],
          push_token : json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['push_token'],
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