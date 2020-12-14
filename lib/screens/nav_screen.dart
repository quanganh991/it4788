import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/widgets/Notification/notification_screen.dart';
import 'package:fakebook_homepage/widgets/Personal/get_all_friends_list.dart';
import 'package:fakebook_homepage/controllers/Personal/list_friend_controller.dart';
import 'package:fakebook_homepage/widgets/Personal/get_all_requesting.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/menu_screen.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/view_one_s_profile.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/screens/screens.dart';
import 'package:fakebook_homepage/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends StatefulWidget {
  final users_models currentUser;

  NavScreen({Key key, this.currentUser}) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState(currentUser: currentUser);
}

class _NavScreenState extends State<NavScreen> {  //toàn bộ 6 cái màn hình của ứng dụng
  _NavScreenState({Key key, this.currentUser});

  Future<List<users_models>> listRequestingPerson;

  final users_models currentUser;
  //dưới đây là footer
  final List<IconData> _icons = const [ //6 cái icon tương ứng với 6 cái màn hình của ứng dụng
    Icons.home,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline, //nhóm
    MdiIcons.bellOutline, //notification
    Icons.menu,
  ];
  int _selectedIndex = 0; //ban đầu chưa chọn màn hình nào

  @override
  void initState() {
    super.initState();
    print("----------------------gọi API get all requesingizione");
    listRequestingPerson = list_friend_controller.GetAllRequesting(currentUser.id_users.toString()); //lấy tất cả bạn bè của người được xem, trong trường hợp mình tự xem chính mình thì sẽ là tất cả bạn bè của mình
  }

  @override
  Widget build(BuildContext context) {
    //print("--------Chuyển sang NavScreen thì: " + currentUser.username + " --- " + currentUser.password);
    return DefaultTabController(
      length: _icons.length,  //số lượng icon (6)
      child: Scaffold(
        appBar: null, //trên mobile
        body: IndexedStack(
          index: _selectedIndex,//màn hình nào được chọn
          children: [
            HomeScreen(currentUser: currentUser),
            ProfileScreen(currentUser: currentUser, viewedUser: currentUser),


            //futurBuilder
            FutureBuilder(
                                  future: list_friend_controller.GetAllRequesting(currentUser.id_users.toString()),
                                  //là 1 cái mảng chứa tất cả bạn bè
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print("------------------------số riquesto = " + snapshot.data.length.toString());
                                      return
                                        ListRequestingPerson(viewedUser: currentUser, currentUser: currentUser, listRequestingPerson: snapshot.data);
                                    } else {
                                      return Scaffold(
                                          appBar: AppBar(

                                          backgroundColor: Colors.deepOrange,
                                          title: Text("0 requesting " + currentUser.name.toString()),
                                    ),
                                    body: Container());
                                    }
                                  },
                                ),
            //futureBuilder





            NotificationScreen(currentUser: currentUser),
            MenuScreen(currentUser: currentUser),
            // Scaffold(),

          ], //toàn bộ 6 cái màn hình của ứng dụng
        ),
        bottomNavigationBar: Container(  //mobile
          padding: const EdgeInsets.only(bottom: 12.0), //khoang cách từ 6 nút footer tới mép dưới cùng của màn hình điện thoại
          color: Colors.white,  //màu của khung chứa 5 nút
          child: CustomTabBar(
            icons: _icons,  //toàn bộ 6 icon
            selectedIndex: _selectedIndex,  //màn hình nào đang hiển thị
            onTap: (index) => setState(() => _selectedIndex = index), //thay đổi chỉ số màn hình đang hiển thị
          ),
        )
      ),
    );
  }
}
