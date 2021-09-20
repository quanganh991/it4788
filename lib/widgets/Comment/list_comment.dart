import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/Comment/comment_controller.dart';
import 'package:fakebook_homepage/models/combine_comments_users_models.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/Comment/comment_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


class ListComment extends StatefulWidget {
  final combine_posts_users_models posts;
  final users_models currentUser;

  const ListComment({Key key, @required this.posts, @required this.currentUser}) : super(key: key);

  ListCommentState createState() => ListCommentState(posts: posts, currentUser: currentUser);
}

class ListCommentState extends State<ListComment> {

  final combine_posts_users_models posts;
  final users_models currentUser;

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  Future<List<combine_comments_users_models>> allComments;  //tất cả các comment của 1 bài post nào đó


  ListCommentState({Key key, @required this.posts, @required this.currentUser}) : super();

  @override
  void initState() {
    super.initState();

    allComments = comment_controller.GetAllCommentsOfAPost(posts.id_posts.toString()); //lấy tất cả các comment của post có id_posts
  }


  @override
  Widget build(BuildContext context) {
    return
    Card(
      margin: EdgeInsets.only(top: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular((10)),
            topRight: Radius.circular(10)
        ),),


      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            //height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0), //kích cỡ của hình bao quanh icon like
                  decoration: BoxDecoration(
                    //hình bao quanh icon like
                    color: Palette.facebookBlue, //hình bao quanh icon like có nền xanh
                    shape:
                    BoxShape.circle, //hình bao quanh icon like là hình tròn
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
                  posts.likes_post.toString(), //số like
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
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 0),
            alignment: Alignment.centerLeft,
            child: FlatButton(
              //padding: EdgeInsets.only(top: 0),

              child: Text("More comments...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),

            ),
          ),


          FutureBuilder(  //tất cả các comment của bài post này
            // future: allComments, //trả về tất cả bình luận của bài viết có id post
            future: comment_controller.GetAllCommentsOfAPost(posts.id_posts.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                print("-----------------CÓ tất cả số comment là = " + snapshot.data.length.toString());
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,  //trả về 1 list view độ dài là số comment của bài viết đó
                    itemBuilder: ((context, index) {  //tại mỗi comment của bài viết
                      return Container(







                        child: CommentItem( //combine_comments_users_models
                            eachComment: snapshot.data[index],  //truyền từng cái comment sang bên kia
                        ), //từng dòng trong danh sách người like, truyền vào id của người dùng












                      );
                    }),
                  ),
                );
              }
              return Container();
            },
          ),


          buildInput(context),

        ],
      ),
    );

  }


  Widget buildInput(context) { //thanh ngang dưới cùng chứa 4 item
    return
      Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: Colors.grey,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                // onPressed: getSticker,
                color: Colors.grey, onPressed: () {
                  Navigator.pop(context,0);
              },
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                focusNode: focusNode,
                onSubmitted: (value) {
                  CreateComment(textEditingController.text, posts, currentUser);
                },
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => {
                  CreateComment(textEditingController.text, posts, currentUser),
                // Navigator.pop(context,0)

              },
                color: Colors.grey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    )
    //
      );
  }

  void CreateComment(String content, combine_posts_users_models posts , users_models currentUser) {  //khi ấn nút gửi tin nhắn đi, gửi kiểu tin nhắn và nội dung tin nhắn đi
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') { //xử lý khoảng trắng
      textEditingController.clear();  //gửi 1 phát là khung nhập tin nhắn ko còn gì nữa

      //Lưu vào database

      String media_comment = "";
      if(content.contains("https://")){
        media_comment = content.substring(content.indexOf("https://"));
        content = content.substring(0, content.indexOf("https://"));
      }
      print("-------------tách media_comment = " + media_comment);
      print("-------------tách content = " + content);
      comment_controller.CreateComment(content, media_comment, posts, currentUser);

      //lưu vào database
    } else {  //nếu người dùng gửi khoảng trắng đi
      Fluttertoast.showToast(
          msg: 'Bạn chưa nhập nội dung',
          backgroundColor: Colors.black,
          textColor: Colors.red);
    }
  }

  getImage() async {
    const url = 'https://vi.imgbb.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}