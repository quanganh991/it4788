import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/controllers/Personal/block_controller.dart';

import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockList extends StatefulWidget {
  final users_models currentUser;

  const BlockList({Key key, @required this.currentUser})
      : super(key: key);

  BlockListState createState() => BlockListState( currentUser: currentUser);
}

class BlockListState extends State<BlockList> {

  final users_models currentUser;
  Future<List<users_models>> allBlockedUsers;


  BlockListState({Key key, @required this.currentUser}) : super(); //truyền vào id của bài post

  @override
  void initState() {
    super.initState();
    allBlockedUsers = block_controller.GetAllBlockedUsers(currentUser.id_users.toString()); //lấy danh sách tất cả người bị chặn của mình
  }

  @override
  Widget build(BuildContext context) {
    return


    FutureBuilder(
      future: block_controller.GetAllBlockedUsers(currentUser.id_users.toString()), //là 1 cái mảng chứa tất cả người dùng
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          return
      Scaffold(
      appBar: AppBar(
        title: Text(snapshot.data.length.toString() + " blocked users of " + currentUser.name.toString()),
      ),
      body: Column(
        children: [
          Divider(
            color: Colors.grey,
          ),

          Expanded(
            child: ListView.builder(  //List chứa tất cả các người like bài viết
              itemCount: snapshot.data.length,  //số người đã like bài viết có id_post
              itemBuilder: ((context, index) {
                return Container(
                    child: Container(
                      height: 35,
                      child: Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              //Ấn 1 phát thì gọi API bỏ chặn ngay lập tức
                              block_controller.Unblock(currentUser.id_users.toString(), snapshot.data[index].id_users.toString());
                              //Ấn 1 phát thì gọi API bỏ chặn ngay lập tức
                            },
                            child: Row(
                              children: [
                                ProfileAvatar(
                                    radius: 15.0,
                                    imageUrl: snapshot.data[index].avatar.toString()),
                                SizedBox(width: 15,),
                                Text(snapshot.data[index].name.toString(), style: TextStyle(color: Colors.black),),
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
        else {
          return  Scaffold(
              appBar: AppBar(
              title: Text("0 blocked users of " + currentUser.name.toString()),
              ),
                body: Container()
          );
        }
      },
    );

  }
}
