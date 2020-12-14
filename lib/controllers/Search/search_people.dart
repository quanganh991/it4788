import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/recent_searched.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Search{  //lấy post JOIN giữa

  static Future<List<users_models>> GetAllPeopleMatching(String id_users, String keyword) async {
    final http.Response response = await http.post("http://" + IP_ADDRESS + "/api/search/",
      body: {
        'id_users': id_users,
        'keyword' : keyword
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
      //
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<void> save_search_keyword(String id_users, String keyword) async {
    final http.Response response = await http.post("http://" + IP_ADDRESS + "/api/save_search/",
      body: {
        'id_users': id_users,
        'keyword' : keyword
      },
    );

    print("------------------đã lưu 567 body " + json.decode(utf8.decode(response.bodyBytes)).toString());

    if (response.statusCode == 201) {

      //
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }




  static Future<List<recent_searched>> get_recent_keyword(String id_users) async {
    final http.Response response = await http.post("http://" + IP_ADDRESS + "/api/get_saved_search/",
      body: {
        'id_users': id_users,
      },
    );


    if (response.statusCode == 201) {
      List<recent_searched> result = new List<recent_searched>();
      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']["num_rows"].toString()) ; i++){
        result.add(new recent_searched(
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],
          time_search: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_search'],
          id_searchs: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_searchs'],
          keyword: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['keyword'],
        ));
      }
      return result;
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}