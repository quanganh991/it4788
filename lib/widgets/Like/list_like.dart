import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/Like/LikeController.dart';
import 'package:fakebook_homepage/models/combine_likes_users_model.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/Like/person_like_item.dart';

class ListLike extends StatefulWidget {
  final combine_posts_users_models each_post; //truyền vào id của bài post
  final users_models currentUser;


  const ListLike({Key key, @required this.each_post, @required this.currentUser
  }) : super(key: key);

  ListLikeState createState() => ListLikeState(each_post: each_post, currentUser: currentUser);
}

class ListLikeState extends State<ListLike> {
  final combine_posts_users_models each_post;
  final users_models currentUser;

  Future<List<combine_likes_users_model>> each_user;

  ListLikeState({Key key, @required this.each_post,  @required this.currentUser})
      : super(); //truyền vào id của bài post

  @override
  void initState() {
    super.initState();
    each_user = LikeController.GetAllLikesOfAPost(each_post.id_posts
        .toString()); //trả về 1 mảng chứa những người đã like bài viết có id_posts
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LikeController.GetAllLikesOfAPost(each_post.id_posts.toString()),
      //là 1 cái mảng chứa tất cả người dùng
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data.length.toString() + " people like this post"),
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  //height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                            4.0), //kích cỡ của hình bao quanh icon like
                        decoration: BoxDecoration(
                          //hình bao quanh icon like
                          color: Palette.facebookBlue,
                          //hình bao quanh icon like có nền xanh
                          shape: BoxShape
                              .circle, //hình bao quanh icon like là hình tròn
                        ),
                        child: const Icon(
                          //icon like
                          Icons.thumb_up,
                          size: 10.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        snapshot.data.length.toString(), //số like
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView.builder(
                    //List chứa tất cả các người like bài viết
                    itemCount: snapshot.data.length,
                    //số người đã like bài viết có id_post
                    itemBuilder: ((context, index) {
                      return Container(
                          child: PersonLikeItem(
                        //truyền vào id của từng người
                        each_user: snapshot.data[index],
                            currentUser: currentUser,
                      )

                          //từng dòng trong danh sách người like, truyền vào id của người dùng
                          );
                    }),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
              appBar: AppBar(
              title: Text(each_post.likes_post.toString() + " người đã thích bài viết này"),
        ),
        body: Container());
        }
      },
    );
  }
}
