import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakebook_homepage/controllers/Personal/add_friend_controller.dart';
import 'package:fakebook_homepage/controllers/Personal/block_controller.dart';
import 'package:fakebook_homepage/controllers/Personal/list_friend_controller.dart';
import 'package:fakebook_homepage/controllers/PostFromMine/post_from_mine_controller.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:fakebook_homepage/widgets/Personal/get_all_blocked_list.dart';
import 'package:fakebook_homepage/widgets/Personal/get_all_friends_list.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/error.dart';
import 'package:fakebook_homepage/widgets/PostFromFriend/posts_from_one_person_only.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ProfileScreen extends StatefulWidget {
  final users_models currentUser; //người đi xem profile của người được xem
  final users_models viewedUser; //id của người được xemm profile (bởi người đi xem)

  const ProfileScreen(
      {Key key, @required this.currentUser, @required this.viewedUser})
      : super(key: key);

  @override
  _ProfileScreenState createState() =>
      _ProfileScreenState(currentUser: currentUser, viewedUser: viewedUser);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final users_models currentUser; //người được xem profile bởi người đi xem
  final users_models viewedUser; //id của người được xemm profile (bởi người đi xem)

  Future<List<combine_posts_users_models>> allPosts;
  Future<List<users_models>> allFriends;

  Future<int>relationship; //0: Chưa kết bạn, 1: Đang chờ, 2: Đã kết bạn, 3: Bị chặn

  _ProfileScreenState(
      {Key key, @required this.viewedUser, @required this.currentUser})
      : super();

  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    allPosts = post_from_mine_controller.GetAllPostFromAPerson(viewedUser
        .id_users
        .toString()); //lấy tất cả bài viết của người được xem chứ ko phải là người đi xem
    relationship = add_friend_controller.ViewRelationShip(
        currentUser.id_users.toString(), viewedUser.id_users.toString()
    ); //Xem mối quan hệ bạn bè của 2 người
    allFriends = list_friend_controller.GetAllFriends(viewedUser.id_users.toString()); //lấy tất cả bạn bè của người được xem, trong trường hợp mình tự xem chính mình thì sẽ là tất cả bạn bè của mình
  }

  @override
  Widget build(BuildContext context) {
    return currentUser.id_users.toString() == viewedUser.id_users.toString() //kiểm tra xem tự xem mình hay xem người khác

        ? Scaffold(
            //tự mình xem profile của mình
            appBar: null,
            body: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: 500,
                          color: Colors.white,
                        ),
                        Container(
                          height: 200,
                          width: 500,
                          child: ClipRect(
                            child: CachedNetworkImage(imageUrl: viewedUser.cover_picture.toString()),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          left: 330,
                          child: Container(
                            height: 40,
                            width: 50,
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.grey[300],
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: 120,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: CachedNetworkImageProvider(viewedUser.avatar.toString()),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 210,
                          left: 240,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      viewedUser.name.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            width: 280,
                            height: 45,
                            color: Colors.blueAccent,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(Icons.edit)),
                                SizedBox(
                                  width: 15,
                                ),

                                Text(
                                  "Update Personal Informazione",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            width: 70,
                            height: 45,
                            color: Colors.grey[300],
                            child: FlatButton(
                                onPressed: () {
                                  //chuyển sang màn hình danh sách người bị chặn
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => BlockList(currentUser: currentUser)
                                      ));
                                },
                                child: Icon(Icons.block),
                            )
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.business_center,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                viewedUser.company.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Live in",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                viewedUser.city.toString() +
                                    " - " +
                                    viewedUser.country.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Container(
                        width: 300,
                        height: 40,
                        color: Colors.lightBlue[50],
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                                height: 40,
                                width: 300,
                                child: Center(
                                    child: Text(
                                  "Edit profile details",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Friends",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Friend Request",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blueAccent),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                FutureBuilder(
                                  future: allFriends,
                                  //là 1 cái mảng chứa tất cả bạn bè
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.length.toString() +
                                            " friends",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      );
                                    } else {
                                      return Text(
                                        "0 friends",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        )),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FutureBuilder(
                            future: allFriends,
                            //là 1 cái mảng chứa tất cả người dùng
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                        //Mỗi 1 expand là 1 người theo hàng ngang
                                        child: Card(
                                      child: Column(
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileScreen(
                                                            currentUser:
                                                                currentUser,
                                                            viewedUser: snapshot
                                                                .data[0],
                                                          )));
                                            },
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data[0].avatar
                                                      .toString(),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              width: 100,
                                              child: Text(
                                                snapshot.data[0].name
                                                    .toString(),
                                                style: TextStyle(fontSize: 18),
                                                textAlign: TextAlign.left,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    )),
                                    snapshot.data.length >= 2
                                        ? Expanded(
                                            child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileScreen(
                                                                  currentUser:
                                                                      currentUser,
                                                                  viewedUser:
                                                                      snapshot
                                                                          .data[1],
                                                                )));
                                                  },
                                                  child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data[1].avatar
                                                            .toString(),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot.data[1].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                      textAlign: TextAlign.left,
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          ))
                                        : Container(),
                                    snapshot.data.length >= 3
                                        ? Expanded(
                                            child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileScreen(
                                                                  currentUser:
                                                                      currentUser,
                                                                  viewedUser:
                                                                      snapshot
                                                                          .data[2],
                                                                )));
                                                  },
                                                  child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data[2].avatar
                                                            .toString(),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot.data[2].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                      textAlign: TextAlign.left,
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          ))
                                        : Container(),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Container(
                              height: 40,
                              width: 350,
                              color: Colors.grey[300],
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                      height: 40,
                                      width: 350,
                                      child: Center(
                                        child:

                                        FutureBuilder(
                                          future: allFriends,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                ListFriend(listFriends: snapshot.data, currentUser: currentUser, viewedUser: viewedUser)
                                                        )
                                                    );
                                                  },
                                                  child: Text(
                                                    "See All Friends",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  ),

                                                );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),

                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey[370],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: CachedNetworkImageProvider(
                                      currentUser.avatar.toString()),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                FlatButton(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'What\'s on your mind?',
                                        textDirection: TextDirection.ltr,
                                      )),
                                  onPressed: () => {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => CreatePost(
                                              currentUser: currentUser,
                                            )))
                                  },
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 10,
                      color: Colors.grey[370],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 10,
                      color: Colors.grey[370],
                    ),
                  ],
                ),
                FutureBuilder(
                  future: allPosts, //là 1 cái mảng chứa tất cả người dùng
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return
                        Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          color: Colors.white,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 8.0,
                            ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: PostFromOnePersonContainer(
                                id_users: viewedUser.id_users.toString(),
                                currentUser: currentUser,
                                index_post: index,
                              ),
                            );
                          },
                        )
                        );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          )







        : //mình đi xem profile của người khác

        Scaffold(
            appBar: null,
            body: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: 500,
                          color: Colors.white,
                        ),
                        Container(
                          height: 200,
                          width: 500,
                          child: ClipRect(
                            child: CachedNetworkImage(
                                imageUrl: viewedUser.cover_picture.toString()),
                          ),
                        ),
                        Positioned(
                          top: 120,
                          left: 120,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: CachedNetworkImageProvider(
                                  viewedUser.avatar.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      viewedUser.name.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            width: 280,
                            height: 45,
                            color: Colors.blueAccent,
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                //

                                FutureBuilder(
                                  future: add_friend_controller.ViewRelationShip(
                                      currentUser.id_users.toString(), viewedUser.id_users.toString()
                                  ),
                                  builder: (context, snapshot) {
                                    print("---------------relationshippia = " + snapshot.hasData.toString());
                                    if (snapshot.hasData) {
                                      String relation = "";

                                      if (snapshot.data == 0) { //chưa kết bạn
                                        //Chưa kết bạn
                                        relation = "Add Friend";
                                        return FlatButton(
                                          child: Text(
                                            relation,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => {
                                            //ấn thì gửi yêu cầu kết bạn
                                            add_friend_controller.AddFriend(
                                                currentUser.id_users.toString(),
                                                viewedUser.id_users.toString()),
                                            setState(() {
                                              relation = "Pending";
                                            })
                                          },
                                        );
                                      } else if (snapshot.data == 1) {  //đã gửi yêu cầu kết bạn nhưng đang chờ phản hồi
                                        //Đang chờ
                                        relation = "Pending";
                                        return FlatButton(
                                          child: Text(
                                            relation,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => {
                                            //Ấn thì bỏ yêu cầu kết bạn
                                            add_friend_controller.Unfriend(
                                                currentUser.id_users.toString(),
                                                viewedUser.id_users.toString()),
                                            setState(() {
                                              relation = "Add Friend";
                                            })
                                          },
                                        );
                                      } else if (snapshot.data == 2) {  //đã nhận được yêu cầu kết bạn và chờ phản hồi
                                        //Đã add friend
                                        relation = "Sent you an add friend requestto";
                                        return FlatButton(
                                          child: Text(
                                            relation,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => { //Ấn 1 phát thì chấp nhận
                                            add_friend_controller.AcceptFriendReq(
                                                currentUser.id_users.toString(),
                                                viewedUser.id_users.toString()),
                                            setState(() {
                                              relation = "You are friend";
                                            })
                                          },
                                          onLongPress: () => {  //Ấn dài thì không chấp nhận kết bạn
                                            add_friend_controller.Unfriend(
                                                currentUser.id_users.toString(),
                                                viewedUser.id_users.toString()),
                                            setState(() {
                                              relation = "Add friend";
                                            })
                                          },
                                        );
                                      } else if (snapshot.data == 3) {  //đã trở thành bạn bè
                                        //bị chặn
                                        relation = "You are friend";
                                        return FlatButton(
                                          child: Text(
                                            relation,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => {
                                            //Ấn thì hủy kết bạn
                                            add_friend_controller.Unfriend(
                                                currentUser.id_users.toString(),
                                                viewedUser.id_users.toString()),
                                            setState(() {
                                              relation = "Add Friend";
                                            })
                                          },
                                        );
                                      }
                                      else if (snapshot.data == 4) {  //chặn/ bị chặn
                                        //bị chặn
                                        relation = "Blocked";
                                        WidgetsBinding.instance.addPostFrameCallback((_){
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) => ErrorScreen()));
                                        });
                                        return Container();
                                      } else {
                                        return Text(
                                          "No information",
                                          style: TextStyle(color: Colors.white),
                                        );
                                      }
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),

                                //
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: FlatButton(  //gọi API chặn
                          onPressed: () {
                            block_controller.Block(currentUser.id_users.toString(), viewedUser.id_users.toString());
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 70,
                            height: 45,
                            color: Colors.grey[300],
                            child: Icon(Icons.block),
                          ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.business_center,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                viewedUser.company.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Live in",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                viewedUser.city.toString() +
                                    " - " +
                                    viewedUser.country.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Friends",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //Hiển thị mẫu 3 người ra
                            Row(
                              children: <Widget>[
                                FutureBuilder(
                                  future: allFriends,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.length.toString() +
                                            " friends",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      );
                                    } else {
                                      return Text(
                                        "0 friends",
                                        style: TextStyle(fontSize: 15, color: Colors.grey),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        )),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FutureBuilder(
                            future: allFriends,
                            //là 1 cái mảng chứa tất cả người dùng
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                        //Mỗi 1 expand là 1 người theo hàng ngang
                                        child: Card(
                                      child: Column(
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileScreen(
                                                            currentUser:
                                                                currentUser,
                                                            viewedUser: snapshot
                                                                .data[0],
                                                          )));
                                            },
                                            child: Container(
                                                height: 150,
                                                width: 150,
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data[0].avatar
                                                      .toString(),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              width: 100,
                                              child: Text(
                                                snapshot.data[0].name
                                                    .toString(),
                                                style: TextStyle(fontSize: 18),
                                                textAlign: TextAlign.left,
                                              )),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    )),
                                    snapshot.data.length >= 2
                                        ? Expanded(
                                            child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileScreen(
                                                                  currentUser:
                                                                      currentUser,
                                                                  viewedUser:
                                                                      snapshot
                                                                          .data[1],
                                                                )));
                                                  },
                                                  child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data[1].avatar
                                                            .toString(),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot.data[1].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                      textAlign: TextAlign.left,
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          ))
                                        : Container(),
                                    snapshot.data.length >= 3
                                        ? Expanded(
                                            child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProfileScreen(
                                                                  currentUser:
                                                                      currentUser,
                                                                  viewedUser:
                                                                      snapshot
                                                                          .data[2],
                                                                )));
                                                  },
                                                  child: Container(
                                                      height: 150,
                                                      width: 150,
                                                      child: CachedNetworkImage(
                                                        imageUrl: snapshot
                                                            .data[2].avatar
                                                            .toString(),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    width: 100,
                                                    child: Text(
                                                      snapshot.data[2].name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                      textAlign: TextAlign.left,
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          ))
                                        : Container(),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Container(
                              height: 40,
                              width: 350,
                              color: Colors.grey[300],
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                      height: 40,
                                      width: 350,
                                      child: Center(
                                        child:

                                         FutureBuilder(
                            future: allFriends,
                            //là 1 cái mảng chứa tất cả người dùng
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListFriend(listFriends: snapshot.data, currentUser: currentUser, viewedUser: viewedUser)
                                                  )
                                            );
                                          },
                                          child: Text(
                                          "See All Friends",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                          ),

                                        );
                                           } else {
                                return Container();
                              }
                            },
                          ),


                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey[370],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 10,
                      color: Colors.grey[370],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 10,
                      color: Colors.grey[370],
                    ),
                  ],
                ),
                FutureBuilder(
                  future: allPosts, //là 1 cái mảng chứa tất cả người dùng
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return
                        Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            color: Colors.white,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 8.0,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: PostFromOnePersonContainer(
                                    id_users: viewedUser.id_users.toString(),
                                    currentUser: currentUser,
                                    index_post: index,
                                  ),
                                );
                              },
                            )
                        );
                      //   CustomScrollView(
                      //     controller: _trackingScrollController,
                      //     slivers: [
                      //       SliverList(
                      //         //khung chứa các bài đăng của người dùng
                      //         delegate: SliverChildBuilderDelegate((context, index) {
                      //             return Container(
                      //               child: PostFromOnePersonContainer(
                      //                 id_users: viewedUser.id_users,
                      //                 currentUser: currentUser,
                      //                 index_post: index,
                      //               ),
                      //             );
                      //           },
                      //           childCount: snapshot.data.length,
                      //         ),
                      //       ),
                      //     ],
                      //   );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          );
  }
}
