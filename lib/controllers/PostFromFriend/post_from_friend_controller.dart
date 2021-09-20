import 'dart:convert';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class post_from_friend_controller{
  static Future<List<combine_posts_users_models>> GetAllPostFromFriend(String id_users) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_list_posts/",
      body: {
        'id_users': id_users,
      },
    );

    if (response.statusCode == 201) {
      List<combine_posts_users_models> result = new List<combine_posts_users_models>();

      print("--------------@@--------------json.bodia = " + response.body.toString());

      for(int i = 0; i < int.parse(json.decode(utf8.decode(response.bodyBytes))['data']['num_rows'].toString()) ; i++){
        print("----------------so post newfeedia ['data']['num_rows'] la = " + json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['title'].toString());

        result.add(new combine_posts_users_models(
          id_posts: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_posts'],
          likes_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['likes_post'],
          comment_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['comment_post'],
          media_url: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['media_url'],
          shares_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['shares_post'],
          time_post: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['time_post'],
          title: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['title'],
          id_users: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['id_users'],
          username: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['username'],
          password: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['password'],
         name:  json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['name'],
         //  name:  json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['name'],

          avatar: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['avatar'],
          create_at: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['create_at'],
          push_token: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['push_token'],

          cover_picture: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['cover_picture'],
          country: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['country'],
          city: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['city'],
          company: json.decode(utf8.decode(response.bodyBytes))['data'][i.toString()]['company'],

    ));
      }


      return result;
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }


  static Future<combine_posts_users_models> GetPostDetailFromId(String id_posts) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_post/",
      body: {
        'id_posts': id_posts,
      },
    );


    if (response.statusCode == 201) {
      combine_posts_users_models result;

        result = (new combine_posts_users_models(
          id_posts: json.decode(utf8.decode(response.bodyBytes))['data']['id_posts'],
          likes_post: json.decode(utf8.decode(response.bodyBytes))['data']['likes_post'],
          comment_post: json.decode(utf8.decode(response.bodyBytes))['data']['comment_post'],
          media_url: json.decode(utf8.decode(response.bodyBytes))['data']['media_url'],
          shares_post: json.decode(utf8.decode(response.bodyBytes))['data']['shares_post'],
          time_post: json.decode(utf8.decode(response.bodyBytes))['data']['time_post'],
          title: json.decode(utf8.decode(response.bodyBytes))['data']['title'],
          id_users: json.decode(utf8.decode(response.bodyBytes))['data']['id_users'],
          username: json.decode(utf8.decode(response.bodyBytes))['data']['username'],
          password: json.decode(utf8.decode(response.bodyBytes))['data']['password'],
          name: json.decode(utf8.decode(response.bodyBytes))['data']['name'],
          avatar: json.decode(utf8.decode(response.bodyBytes))['data']['avatar'],
          create_at: json.decode(utf8.decode(response.bodyBytes))['data']['create_at'],
          push_token: json.decode(utf8.decode(response.bodyBytes))['data']['push_token'],
          cover_picture: json.decode(utf8.decode(response.bodyBytes))['data']['cover_picture'],
          country: json.decode(utf8.decode(response.bodyBytes))['data']['country'],
          city: json.decode(utf8.decode(response.bodyBytes))['data']['city'],
          company: json.decode(utf8.decode(response.bodyBytes))['data']['company'],
        ));

      return result;
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }

  static Stream<combine_posts_users_models> GetPostDetailFromIdRealtime(String id_posts) async*{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/get_post/",
      body: {
        'id_posts': id_posts,
      },
    );


    if (response.statusCode == 201) {
      combine_posts_users_models result;

      result = (new combine_posts_users_models(
        id_posts: json.decode(utf8.decode(response.bodyBytes))['data']['id_posts'],
        likes_post: json.decode(utf8.decode(response.bodyBytes))['data']['likes_post'],
        comment_post: json.decode(utf8.decode(response.bodyBytes))['data']['comment_post'],
        media_url: json.decode(utf8.decode(response.bodyBytes))['data']['media_url'],
        shares_post: json.decode(utf8.decode(response.bodyBytes))['data']['shares_post'],
        time_post: json.decode(utf8.decode(response.bodyBytes))['data']['time_post'],
        title: json.decode(utf8.decode(response.bodyBytes))['data']['title'],
        id_users: json.decode(utf8.decode(response.bodyBytes))['data']['id_users'],
        username: json.decode(utf8.decode(response.bodyBytes))['data']['username'],
        password: json.decode(utf8.decode(response.bodyBytes))['data']['password'],
        name: json.decode(utf8.decode(response.bodyBytes))['data']['name'],
        avatar: json.decode(utf8.decode(response.bodyBytes))['data']['avatar'],
        create_at: json.decode(utf8.decode(response.bodyBytes))['data']['create_at'],
        push_token: json.decode(utf8.decode(response.bodyBytes))['data']['push_token'],
        cover_picture: json.decode(utf8.decode(response.bodyBytes))['data']['cover_picture'],
        country: json.decode(utf8.decode(response.bodyBytes))['data']['country'],
        city: json.decode(utf8.decode(response.bodyBytes))['data']['city'],
        company: json.decode(utf8.decode(response.bodyBytes))['data']['company'],
      ));

      yield result;
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}