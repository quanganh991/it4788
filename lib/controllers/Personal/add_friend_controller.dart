import 'dart:convert';

import 'package:fakebook_homepage/controllers/ipconfig.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:http/http.dart' as http;



class add_friend_controller {

  static Future<void> AddFriend(String id_users_view, String id_users_be_viewed) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/set_request_friend/",
      body: {
        'id_send_users': id_users_view,
        'id_receive_users': id_users_be_viewed,
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }



  static Future<int> ViewRelationShip(String id_users_view, String id_users_be_viewed) async{

    final http.Response response = await http.post("http://"+ IP_ADDRESS +"/api/view_relationship/",
      body: {
        'id_users_view': id_users_view,
        'id_users_be_viewed': id_users_be_viewed,
      },
    );

    print("---------------người gửi id_users_view = " + id_users_view);
    print("---------------người nhận id_users_be_view = " + id_users_be_viewed);

    if (response.statusCode == 201) {
      print("---------------------trạng thái tính bạn = " + json.decode(utf8.decode(response.bodyBytes))['data']['status'].toString());
      return int.parse(json.decode(utf8.decode(response.bodyBytes))['data']['status'].toString());
//"trả về 1 số int:
// 0: Chưa kết bạn - Add friend
// 1: Đang chờ được xác nhận - Friend request sent
// 2. Đang chờ - Confirm
// 3: Đã Add friend - Friend
// 4: Bị chặn - Block"
    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }

  //Chấp nhận kết bạn
  static Future<void> AcceptFriendReq(String id_users_view, String id_users_be_viewed) async{ //Gọi API chấp nhận kết bạn

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/set_accept_friend/",
      body: {
        'id_send_users': id_users_view,
        'id_receive_users': id_users_be_viewed,
      },
    );

    print("---------------người gửi id_send_users = " + id_users_view);
    print("---------------người nhận id_receive_users = " + id_users_be_viewed);

    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }



//Unfriend
  static Future<void> Unfriend(String id_users_view, String id_users_be_viewed) async{

    final http.Response response = await http.post("http://"+IP_ADDRESS+"/api/cancel_friend/",
      body: {
        'id_users_view': id_users_view,
        'id_users_be_viewed': id_users_be_viewed,
      },
    );


    if (response.statusCode == 201) {

    }
    else {
      throw Exception('Failed to create album.' + response.statusCode.toString());
    }
  }
}