
import 'package:fakebook_homepage/models/combine_notification_users_model.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/widgets/Notification/notification_item.dart';
import 'package:fakebook_homepage/controllers/Notification/notification_controller.dart';

class NotificationScreen extends StatefulWidget {

  final users_models currentUser;

  const NotificationScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState(currentUser: currentUser);
}

class _NotificationScreenState extends State<NotificationScreen> {

  final users_models currentUser;
  _NotificationScreenState({Key key, this.currentUser}) : super() ;

  Future<List<combine_notification_users_model>> allNotifications;
  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  void initState() {
    super.initState();
    allNotifications = notification_controller.GetAllNotification(currentUser.id_users.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),

      body: Column(
        children: [


          Expanded(
            child: ListView(   // danh sách người like
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
                  child: Text("Earlier", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                FutureBuilder(
      future: allNotifications, //là 1 cái mảng chứa tất cả người dùng
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8.0,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("-----------------số notifica = " + snapshot.data.length.toString());
                    return NotificationItem(
                      currentUser: currentUser,
                      notifiDetail: snapshot.data[index], //truyền vài người dùng xem họ có xem được bài viết ko
                    );
                  },
                )
            );
        }
        else {
          return CircularProgressIndicator();
        }
      },
    ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
