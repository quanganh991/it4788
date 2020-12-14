import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/add_album.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/audience.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/list_action_post.dart';
import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fakebook_homepage/controllers/PostFromMine/post_from_mine_controller.dart';

class EditPost extends StatefulWidget {

  final combine_posts_users_models each_post;
  final users_models currentUser;

  const EditPost({
    Key key,
    @required this.each_post,
    @required this.currentUser,

  }) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState(each_post: each_post, currentUser: currentUser);

}

class _EditPostState extends State<EditPost> {
  final combine_posts_users_models each_post;
  final users_models currentUser;

  bool _keyboardVisible = false;
  String ViewMode = "Public";
  IconData _iconData = Icons.public;
  final TextEditingController textEditingController = TextEditingController();  //chứa tin nhắn đang soạn

  _EditPostState({Key key, @required this.each_post, @required this.currentUser});

  @override
  void initState() {
    super.initState();
    textEditingController.text = each_post.title.toString() + " " + each_post.media_url.toString();
  }

  //Hàm lưu vào DB
  void onSendMessage(String content, int type) {  //khi ấn nút gửi tin nhắn đi, gửi kiểu tin nhắn và nội dung tin nhắn đi
    if (content.trim() != '') { //xử lý khoảng trắng
      textEditingController.clear();
      String media_url = "";
      if(content.contains("https://")){
        media_url = content.substring(content.indexOf("https://"));
        content = content.substring(0, content.indexOf("https://"));
      }
      print("-------------tách media_url = " + media_url);
      print("-------------tách content = " + content);

      //Lưu dữ liệu vào Mysql
      post_from_mine_controller.EditMyOwnPost(each_post.id_posts.toString(), content, media_url);
      //Lưu dữ liệu vào MySQL

      textEditingController.clear();  //gửi 1 phát là khung nhập tin nhắn ko còn gì nữa

    } else {  //nếu người dùng gửi khoảng trắng đi
      Fluttertoast.showToast(
          msg: 'Bạn chưa nhập nội dung',
          backgroundColor: Colors.black,
          textColor: Colors.red);
    }
  }
  //Hàm lưu vào firestore

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Edit Post', style: new TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen,
        actions: [
          FlatButton(
              child: Text('Post', style: TextStyle(fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),),
              onPressed: () {
                onSendMessage(textEditingController.text, 0);
                Navigator.pop(context);
                //
                //Ấn nút đăng bài
              } //Navigator.push(context, new MaterialPageRoute(builder: null)),

          )
        ],
      ),


      body:


      Stack(
        children: [
          Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ProfileAvatar(
                          imageUrl: currentUser.avatar.toString()
                      ),

                      SizedBox(width: 15.0,),
                      Expanded( //Expanded làm việc với Flex/Flexbox layout. Nó là một trong những widget tốt nhất để phân chia không gian giữa các items với nhau
                        child: Column( //chủ thớt và (thời gian đăng, chế độ xem) được xếp dọc
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //tên chủ thớt được đặt ở bên trái,

                          children: [


                            Text(
                              currentUser.name.toString(),
                              //tên chủ thớt
                              style: const TextStyle(
                                fontWeight: FontWeight.w600, //độ đậm
                              ),
                            ),


                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //
                                StreamBuilder<String>(
                                  stream: _loadData(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    // if (snapshot.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container( //Public
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3))
                                        ),
                                        margin: EdgeInsets.only(left: 0),
                                        child: FlatButton( //Public
                                          padding: EdgeInsets.only(
                                              left: 2, right: 2),
                                          child: Row( //Public
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              //Public
                                              Icon( //chế độ xem
                                                _iconData, //biến thiên
                                                color: Colors.grey[600],
                                                size: 15.0,
                                              ),
                                              SizedBox(width: 5.0,),
                                              Text(ViewMode,
                                                textDirection: TextDirection
                                                    .ltr,),
                                              //ViewMode cũng biến thiên
                                              SizedBox(width: 1.0,),
                                              Icon( //chế độ xem
                                                Icons.arrow_drop_down,
                                                color: Colors.grey[600],
                                                size: 15.0,
                                              ),
                                            ], //Public

                                          ), //Public
                                          onPressed: () => _navigateAndDisplaySelection(context), //chọn chế độ xem: Public/ Friend/ Only me
                                        ), //Public

                                      ), //Public
                                    );
                                    // }
                                    // else {
                                    //   return Center(child: CircularProgressIndicator());
                                    // }
                                  },
                                ),
                                //

                                SizedBox(width: 5,),


                                Container( //Album
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3))
                                  ),
                                  child: FlatButton( //Album
                                    padding: EdgeInsets.only(left: 2, right: 2),
                                    child: Row( //Album
                                      children: [
                                        Icon( //chế độ xem
                                          Icons.add,
                                          color: Colors.grey[600],
                                          size: 15.0,
                                        ),
                                        SizedBox(width: 3.0,),
                                        Text('Album'),
                                        SizedBox(width: 1.0,),
                                        Icon( //chế độ xem
                                          Icons.arrow_drop_down,
                                          color: Colors.grey[600],
                                          size: 15.0,
                                        ),

                                      ],
                                    ), //Album
                                    onPressed: () =>
                                        Navigator.push(context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    AddToAlBum())),
                                  ), //Album

                                ), //Album

                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 10),

                  TextField(
                    onSubmitted: (value) {
                      onSendMessage(textEditingController.text, 0);
                    },
                    controller: textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'What\'s on your mind?',
                    ),
                    maxLines: 7,
                  ),

                  _keyboardVisible == false && textEditingController.text.toString().contains("https://")
                      ?
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CachedNetworkImage(imageUrl: textEditingController.text.toString().substring(textEditingController.text.toString().indexOf("https://")))
                      ]
                  )
                      :
                  // Text("Hallo")
                  Container()

                ],
              )
          ),


          ListActionPost(keyboardVisible: _keyboardVisible),

        ],
      ),
    );
  }
  Future<String> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(  //chuyển sang trang chọn kiểu view của post, chờ kq trả về
      context,
      MaterialPageRoute(builder: (context) => Audience()),
    );
    if (result == "0") {
      ViewMode = "Public";
      _iconData = Icons.public;
    }
    else if (result == "1") {
      ViewMode = "Friends";
      _iconData = Icons.people;

    }
    else if (result == "2") {
      ViewMode = "Only me";
      _iconData = Icons.lock;

    }
    else {
      ViewMode = "Error";
      _iconData = Icons.error;
    }
    return ViewMode;
  }

  Stream<String> _loadData() async* {
    for (int i = 0; i < 1000; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield ViewMode;
    }
    // yield ViewMode;
  }
}
