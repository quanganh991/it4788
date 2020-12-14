import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/models/combine_likes_users_model.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/view_one_s_profile.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';

class PersonLikeItem extends StatefulWidget {
  final combine_likes_users_model each_user;
  final users_models currentUser;

  const PersonLikeItem({
    Key key,
    @required this.each_user,
    @required this.currentUser
  }) : super(key : key);


  PersonLikeItemState createState() => PersonLikeItemState(each_user: each_user, currentUser: currentUser);
}

class PersonLikeItemState extends State<PersonLikeItem> {

  final combine_likes_users_model each_user;
  final users_models currentUser;

  PersonLikeItemState({Key key, @required this.each_user, @required this.currentUser}) : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 35,
      child: Row(
        children: [
          FlatButton(
            onPressed: () {
              Navigator.push( //điều hướng sang màn hình mới (Màn hình HomeScreen)
                context, //điều hướng từ
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(currentUser : currentUser , viewedUser: new users_models(id_users: each_user.id_users
                        , username: each_user.username
                        , password: each_user.password
                        , name: each_user.name
                        , avatar: each_user.avatar
                        , cover_picture: each_user.cover_picture
                        , create_at: each_user.create_at
                        , push_token: each_user.push_token
                        , country: each_user.country
                        , city: each_user.city
                        , company: each_user.company
                    ))
                ),
              );
            },
            child: Row(
              children: [
                ProfileAvatar(
                  radius: 15.0,
                  imageUrl: each_user.avatar.toString()),
                SizedBox(width: 15,),
                Text(each_user.name.toString(), style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}