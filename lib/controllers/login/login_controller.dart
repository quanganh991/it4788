import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class login_controller{
  static Future<users_models> HandleSignIn(String username, String password) async{
    print("--------------reqqd: username = " + username + " password = " + password);
    final http.Response response = await http.post("http://" + IP_ADDRESS + "/api/login/",
      body: {
        'username': username,
        'password': password
      },
    );


    if (response.statusCode == 201) {
      return new users_models(
    id_users: json.decode(utf8.decode(response.bodyBytes))['data']['id_users'],
    username: json.decode(utf8.decode(response.bodyBytes))['data']['username'],
    password: json.decode(utf8.decode(response.bodyBytes))['data']['password'],
    name: json.decode(utf8.decode(response.bodyBytes))['data']['name'],
    avatar: json.decode(utf8.decode(response.bodyBytes))['data']['avatar'],
    create_at: json.decode(utf8.decode(response.bodyBytes))['data']['create_at'],
    push_token: json.decode(utf8.decode(response.bodyBytes))['data']['push_token'],
    company: json.decode(utf8.decode(response.bodyBytes))['data']['company'],
    city: json.decode(utf8.decode(response.bodyBytes))['data']['city'],
    cover_picture: json.decode(utf8.decode(response.bodyBytes))['data']['cover_picture'],
    country: json.decode(utf8.decode(response.bodyBytes))['data']['country']);

    } else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}