import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/Like/LikeController.dart';
import 'package:fakebook_homepage/models/combine_likes_users_model.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/view_one_s_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/Like/person_like_item.dart';

class ListFriend extends StatefulWidget {
  final List<users_models> listFriends; //truyền vào id của bài post
  final users_models currentUser;
  final users_models viewedUser;

  const ListFriend({Key key, @required this.listFriends, @required this.currentUser, @required this.viewedUser})
      : super(key: key);

  ListFriendState createState() => ListFriendState(listFriends: listFriends, currentUser: currentUser, viewedUser: viewedUser);
}

class ListFriendState extends State<ListFriend> {

  final List<users_models> listFriends; //truyền vào id của bài post
  final users_models currentUser;
  final users_models viewedUser;


  ListFriendState({Key key, @required this.listFriends, @required this.currentUser , @required this.viewedUser}) : super(); //truyền vào id của bài post

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listFriends.length.toString() + " friends of " + viewedUser.name.toString()),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.grey,
          ),

          Expanded(
            child: ListView.builder(  //List chứa tất cả các người like bài viết
              itemCount: listFriends.length,  //số người đã like bài viết có id_post
              itemBuilder: ((context, index) {
                return Container(
                  child: Container(
                    height: 35,
                    child: Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(currentUser: currentUser, viewedUser: listFriends[index]),
                                )
                            );
                          },
                          child: Row(
                            children: [
                              ProfileAvatar(
                                  radius: 15.0,
                                  imageUrl: listFriends[index].avatar.toString()),
                              SizedBox(width: 15,),
                              Text(listFriends[index].name.toString(), style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
