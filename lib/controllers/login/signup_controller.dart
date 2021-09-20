import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class signup_controller{
  static Future<users_models> HandleSignUp(String username, String password, String name, String country, String city, String company) async{
    print("--------------reqqd: username = " + username + " password = " + password);
    final http.Response response = await http.post("http://"+ IP_ADDRESS +"/api/signup/",
      body: {
        'username': username.toString(),
        'password': password,
        'name': name,
        'country': country,
        'city': city,
        'company': company,
      },
    );

    if (response.statusCode == 201) {
      return users_models.fromJson(json.decode(utf8.decode(response.bodyBytes))['data']);  //server sẽ trả về 1 bản ghi trong csdl thỏa mãn với username và password kia
    } else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}