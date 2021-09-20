import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/controllers/Notification/notification_controller.dart';
import 'package:fakebook_homepage/controllers/Notification/notification_controller.dart';
import 'package:fakebook_homepage/controllers/PostFromFriend/post_from_friend_controller.dart';
import 'package:fakebook_homepage/models/combine_notification_users_model.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/widgets/Notification/avatar_notification.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/detail_post.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationItem extends StatefulWidget {
  final combine_notification_users_model notifiDetail;
  final users_models currentUser;

  const NotificationItem({
    Key key,
    @required this.notifiDetail,
    @required this.currentUser,

  }) : super(key: key);

  _NotificationItemState createState() => _NotificationItemState(
    notifiDetail: notifiDetail,
      currentUser: currentUser,
  );

}

class _NotificationItemState extends State<NotificationItem>{

  final combine_notification_users_model notifiDetail;
  final users_models currentUser;
  Color isRead;

  _NotificationItemState({Key key, this.notifiDetail, this.currentUser}) : super();
  Future<combine_posts_users_models> eachPost;

  @override
  void initState() {
    super.initState();
    isRead = notifiDetail.readed == 0 ? Colors.blue[50]: Colors.white ;
    eachPost = post_from_friend_controller.GetPostDetailFromId(notifiDetail.id_posts.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isRead, //đã đọc rồi thì trắng còn chưa đọc thì xanh blue[50]
      //width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
      //height: 35,
      child: Row(
        children: [




          FutureBuilder(
      future: eachPost, //là 1 cái mảng chứa tất cả người dùng
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
          FlatButton(
            onPressed: () {
              //ấn vào item thì điều hướng sang màn hình mới và gọi API read
              //Gọi API setread
notification_controller.SetReadNotificate(notifiDetail.id_notifications.toString());
              //
              Navigator.push( //điều hướng sang màn hình mới (Màn hình HomeScreen)
                context, //điều hướng từ
                MaterialPageRoute(
                  builder: (context) => DetailPostContainer(  //currentUser xem eachPost
                      eachPost: snapshot.data , //combine_posts_users_models
                      currentUser: currentUser,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                AvatarNotification(
                  imageUrl: notifiDetail.avatar.toString(),
                  icon: notifiDetail.contents.toString().contains("Liked your post") ? MdiIcons.thumbUp : MdiIcons.comment,
                  circleColor: notifiDetail.contents.toString().contains("Liked your post") ? Colors.green : Colors.blue,
                ),
                SizedBox(width: 15,),
                Container(
                  child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: notifiDetail.name.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          TextSpan(text: " " + notifiDetail.contents.toString(), style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black))
                        ]

                  )),
                )
              ],
            ),
          );
          }
        else {
          return Container();
        }
      },
    ),

          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.mark_chat_read, color: Colors.black,
              ), onPressed: () {
                //Đánh dấu là đã đọc, gọi API đánh dấu đã đọc
              //Gọi API Set read notification
              //read
notification_controller.SetReadNotificate(notifiDetail.id_notifications.toString());

              //Gọi API Set read notification
                setState(() {
                  isRead = Colors.white;
                });
            },
            ),
          )
        ],
      ),
    );
  }
}
