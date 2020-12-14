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

class ListRequestingPerson extends StatefulWidget {
  final List<users_models> listRequestingPerson; //truyền vào id của bài post
  final users_models currentUser;
  final users_models viewedUser;

  const ListRequestingPerson({Key key, @required this.listRequestingPerson, @required this.currentUser, @required this.viewedUser})
      : super(key: key);

  ListRequestingPersonState createState() => ListRequestingPersonState(listRequestingPerson: listRequestingPerson, currentUser: currentUser, viewedUser: viewedUser);
}

class ListRequestingPersonState extends State<ListRequestingPerson> {

  final List<users_models> listRequestingPerson; //truyền vào id của bài post
  final users_models currentUser;
  final users_models viewedUser;


  ListRequestingPersonState({Key key, @required this.listRequestingPerson, @required this.currentUser , @required this.viewedUser}) : super(); //truyền vào id của bài post

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepOrange,
        title: Text(listRequestingPerson.length.toString() + " requesting " + viewedUser.name.toString()),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.grey,
          ),

          Expanded(
            child: ListView.builder(  //List chứa tất cả các người like bài viết
              itemCount: listRequestingPerson.length,  //số người đã like bài viết có id_post
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
                                        ProfileScreen(currentUser: currentUser, viewedUser: listRequestingPerson[index]),
                                  )
                              );
                            },
                            child: Row(
                              children: [
                                ProfileAvatar(
                                    radius: 15.0,
                                    imageUrl: listRequestingPerson[index].avatar.toString()),
                                SizedBox(width: 15,),
                                Text(listRequestingPerson[index].name.toString(), style: TextStyle(color: Colors.black),),
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
