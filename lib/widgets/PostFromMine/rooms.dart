import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/PostFromMine/post_from_mine_controller.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/widgets.dart';

class Rooms extends StatefulWidget {
  final users_models currentUser;

  const Rooms({Key key, this.currentUser}) : super(key: key);

  _RoomState createState() => _RoomState(currentUser: currentUser);
}

class _RoomState extends State<Rooms>{

  final users_models currentUser;

  Future<List<users_models>> allUsers;

  _RoomState({Key key, this.currentUser}) : super();

  @override
  void initState() {
    super.initState();
    allUsers = post_from_mine_controller.GetAllUsers(currentUser.id_users.toString());
  }

  @override
  Widget build(BuildContext context) {
    //print("--------Chuyển sang Room thì: " + currentUser.username + " --- " + currentUser.password);

    return
      allUsers == null

      ?

      CircularProgressIndicator()

      :

      FutureBuilder(
      future: allUsers, //là 1 cái mảng chứa tất cả người dùng
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(  //cả 1 listView
            margin: EdgeInsets.symmetric(horizontal: 0.0), //khoảng cách của khung "Create room" với 2 bên lề trái phải
            elevation: 0.0, //bóng của khung "create room" với bên dưới
            child: Container(
              height: 60.0, //chiều cao của khung "create room"
              color: Colors.white, //màu nền của khung "create room"
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0, //khoảng cách từ đỉnh phía trên của người đang online và mép trên của khung "create room"
                  horizontal: 0.0, //khoảng cách từ viền create room bên trái đến viền trái của khung "create room"
                ),
                scrollDirection: Axis.horizontal, //trượt sang ngang để xem người đang onl"
                //
                itemCount: snapshot.data.length + 1,
                //
                itemBuilder: (BuildContext context, int index) {//index là chỉ số của phần tử trong itemBuilder
                  if (index == 0) {//chỉ số 0 là cái nút "Creae Room" dài
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _CreateRoomButton(), //nút Create Room, chi tiết xem bên dưới
                    );
                  }
                  else if (snapshot.data[index - 1].id_users.toString() == currentUser.id_users.toString()) {  //người đang đăng nhập sẽ ko xuất hiện trên thanh online
                    return Container();
                  }
                  else {  //những người còn lại
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0), //khoảng cách giữa 2 người đang onl trong khung Create Room
                      child: ProfileAvatar(
                        imageUrl: snapshot.data[index - 1].avatar.toString(),
                        isActive: true,
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
        else {
          //return Text(currentUser.username + " --- " + currentUser.password);
          return CircularProgressIndicator();
        }
      },
    );
  }
}

//nút Create Room
class _CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () => print('Create Room'),
      shape: RoundedRectangleBorder(
        //hình dạng của nút 'Create Room'
        borderRadius: BorderRadius.circular(30.0), //là hình chữ nhật cong
      ),
      color: Colors.red,
      borderSide: BorderSide(//viền chữ nhật cong bao quanh chữ "Create Room"
        width: 3.0, //độ dày của cái viền chữ nhật cong bao quanh chữ "Create Room"
        color: Colors.blueAccent[100], //màu của viền chữ nhật cong bao quanh chữ "Create Room"
      ),
      textColor: Palette.facebookBlue,
      //màu của chữ "Create Room" mặc định là màu đen
      child: Row(
        //các thành phần bên trong khung create room: Máy quay và chữ "Create Room"
        children: [
          Icon(
            //dùng máy quay có sẵn trong thư viện
            Icons.video_call,
            size: 35.0, //kích thước
            color: Colors.purple,
          ),
          const SizedBox(width: 4.0),
          //khoảng cách từ máy quay đến chữ "Create Room"
          Text('Create\nRoom'),
        ],
      ),
    );
  }
}
