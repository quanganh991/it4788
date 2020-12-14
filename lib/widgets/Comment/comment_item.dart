import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';

class CommentItem extends StatefulWidget {
  final combine_comments_users_models eachComment;

  const CommentItem({Key key, @required this.eachComment})
      : super(key: key);


  CommentItemState createState() => CommentItemState(eachComment: eachComment);
}

class CommentItemState extends State<CommentItem> {
  final combine_comments_users_models eachComment;
  CommentItemState({Key key, @required this.eachComment}) : super();



  @override
  Widget build(BuildContext context) {


           return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileAvatar(
                      radius: 20.0,
                      imageUrl: eachComment.avatar.toString()),
                  SizedBox(
                    width: 10,
                  ),


                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    constraints: BoxConstraints(
                                      //minWidth: 300.0,
                                      maxWidth: 300.0,
                                      //minHeight: 30.0,
                                      //maxHeight: 100.0,
                                    ),
                                    //margin: EdgeInsets.all(1),
                                    padding: EdgeInsets.all(10),
                                    //width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          eachComment.name.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          eachComment.content_comment.toString(),
                                          maxLines: null,
                                        )
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child:
                                  Text(eachComment.time_comment.toString()),
                                )
                              ],
                            ),

                ],
              ),
            );

  }
}
