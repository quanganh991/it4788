import 'package:fakebook_homepage/controllers/PostFromFriend/post_from_friend_controller.dart';
import 'package:fakebook_homepage/controllers/Stories/stories_controller.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fakebook_homepage/widgets/Search/search.dart';


class HomeScreen extends StatefulWidget {
  final users_models currentUser;

  HomeScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(currentUser: currentUser);
}

class _HomeScreenState extends State<HomeScreen> {
  final users_models currentUser;
  Future<List<combine_posts_users_models>> allPosts_combine_Users;
  Future<List<stories_models>> allStories;

  _HomeScreenState({Key key, @required this.currentUser});

  final TrackingScrollController _trackingScrollController = TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();



    allPosts_combine_Users = post_from_friend_controller.GetAllPostFromFriend(currentUser.id_users.toString());  //lấy tất cả cấc bài post



  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( //mục đích duy nhất ở đây là chỉ cần số lượng post trong DB thôi
        future: allPosts_combine_Users, //tìm trong bảng users với mỗi id_users tương ứng trong posts
        builder: (context, snapshot) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: _HomeScreenMobile(
                  scrollController: _trackingScrollController,
                  currentUser: currentUser, //người dùng hiện tại đang đăng nhập
                  total_post: snapshot.hasData ? snapshot.data.length : 0, //số posts có trong database
                ),
              ),
            );
          // return Text(currentUser.username + " --- " + currentUser.password);
        });
  }
}

class _HomeScreenMobile extends StatelessWidget {
  //màn hình chính
  final TrackingScrollController scrollController;
  final users_models currentUser;
  final int total_post;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollController,
    @required this.currentUser,
    this.total_post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          //logo facebook, logo tìm kiếm (kính lúp) và logo messenger
          brightness: Brightness.light,
          //thanh notification
          backgroundColor: Colors.white,
          title: Text(
            //logo facebook
            'Fakebook',
            style: const TextStyle(
              color: Palette.facebookBlue,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          centerTitle: false,
          //true thì logo "facebook" sẽ nhảy ra giữa
          floating: true,
          //logo nổi/ chìm
          actions: [

            // CircleButton(
            //   //kính lúp tìm kiếm
            //   icon: MdiIcons.exitToApp,
            //   iconSize: 30.0,
            //   onPressed: () {
            //     print('Signout');
            //     Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            //   },
            // ),

            CircleButton(
              //kính lúp tìm kiếm
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () {
                print('Search');
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Search(currentUser: currentUser)));
              },
            ),
            CircleButton(
                //logo messenger
                icon: MdiIcons.facebookMessenger,
                iconSize: 30.0,
                onPressed: () => {
                      print('object'),
                      //handleSignOut(),
                    }),
          ],
        ),






        SliverToBoxAdapter(
          //khung đăng status và (livestream, photo, room)
          child: CreatePostContainer(currentUser: currentUser),
        ),
        SliverPadding(
          //create room
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          //4 tham số là 4 khoảng cách trái, trên, phải, dưới so với 4 widget cạnh nó
          sliver: SliverToBoxAdapter(
            //hiển thị ra tất cả những người đang online để cho người dùng có thể tạo room chat riêng

            // child: Rooms(currentUser: currentUser), //truyền vào người dùng hiện tại






          ),
        ),
        SliverPadding(
          //Khung chứa story
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          //khoảng cách từ viền của story tới viền của khung chứa story
          sliver: SliverToBoxAdapter(
            // child: Stories(currentUser: currentUser,),//Các story
          ),
        ),
        total_post != 0 ? SliverList(
          //khung chứa các bài đăng của người dùng
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              //tại mỗi phần tử trong listView, lại truy vấn tiếp
              return PostContainer(
                  //khi truy vấn tất cả posts, ta cần phải xét xem người dùng đang đăng nhập hiện tại
                  //là currentUserId có được phép xem posts ở vị trí index ko (index chạy từ 0 đến childCount)
                  currentUser: currentUser, //truyền vài người dùng xem họ có xem được bài viết ko
                  index_post: index
              ); //thứ tự bài viết
            },
            childCount: total_post,
          ),
        ) : SliverPadding(padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
      ],
    );
  }
}
