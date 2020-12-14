import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/Like/LikeController.dart';
import 'package:fakebook_homepage/controllers/PostFromFriend/post_from_friend_controller.dart';
import 'package:fakebook_homepage/controllers/PostFromMine/post_from_mine_controller.dart';
import 'package:fakebook_homepage/models/combine_posts_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/widgets/Comment/list_comment.dart';
import 'package:fakebook_homepage/widgets/Like/list_like.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/edit_post.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fakebook_homepage/controllers/PostFromMine/delete_post.dart';

class PostFromOnePersonContainer extends StatefulWidget {
  final String id_users;  //người được xem
  final int index_post;
  final users_models currentUser; //người đi xem

  const PostFromOnePersonContainer({Key key, @required this.index_post, @required this.currentUser, this.id_users})
      : super(key: key);

  PostFromOnePersonContainerState createState() =>
      PostFromOnePersonContainerState(currentUser: currentUser, index_post: index_post, id_users: id_users);
}

class PostFromOnePersonContainerState extends State<PostFromOnePersonContainer> {
  final String id_users;
  final int index_post;
  final users_models currentUser;

  Future<List<combine_posts_users_models>> allPosts_combine_allUsers;

  PostFromOnePersonContainerState({
    Key key,
    @required this.index_post,
    @required this.currentUser,
    this.id_users,
  }) : super();

  @override
  void initState() {
    super.initState();
    allPosts_combine_allUsers = post_from_mine_controller.GetAllPostFromAPerson(id_users.toString()); //lấy tất cả post của friend join thông tin users
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //khung của bài post
      margin: EdgeInsets.symmetric(
        vertical: 5.0, //khoảng cách theo chiều dọc giữa 2 bài post liên tiếp
        horizontal:
        0.0, //khoảng cách theo chiều ngang giữa 2 mép dọc của bài post và các wiget bên cạnh
      ),
      elevation: 0.0,
      //chiều cao của mỗi khung bài post  //độ nổi của khung bài post
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        //khoảng cách từ nội dung của bài post đến 2 mép trên dưới của khung post theo chiều dọc
        color: Colors.white,
        //màu nền của khung post

        child: FutureBuilder(
            future: post_from_mine_controller.GetAllPostFromAPerson(id_users.toString()),
            //tìm trong bảng users với mỗi id_users tương ứng trong stories
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //khoảng cách từ 2 mép dọc màn hình đến title và tên người đăng status
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        //title của status theo thứ tự từ trái sang phải, nếu không thì sẽ xuất hiện từ giữa
                        children: [
                          //1._PostHeader
                          _PostFromOnePersonHeader(
                            each_post: snapshot.data[index_post],
                            currentUser: currentUser,
                          ),
                          //1._PostHeader

                          const SizedBox(height: 4.0),
                          Text(snapshot.data[index_post].title.toString()),

                          snapshot.data[index_post].media_url != null
                              ? const SizedBox.shrink()
                              : const SizedBox(height: 6.0),
                        ],
                      ),
                    ),



                    snapshot.data[index_post].media_url != null
                        ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(
                          imageUrl: snapshot.data[index_post].media_url),
                    )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),

                      //2._PostStats
                      child: _PostFromOnePersonStats(
                        each_post: snapshot.data[index_post],
                        currentUser: currentUser,
                      ),
                      //2_PostStats
                    ),
                  ],
                );
                //chèn StreamBuiler vào đây
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

//1. head của status (chủ thớt, avatar, ngày đăng, các lưa chọn khác, chế độ xem,...)
class _PostFromOnePersonHeader extends StatefulWidget {
  //phía head của status (chủ thớt, avatar, ngày đăng, các lưa chọn khác, chế độ xem,...)
  final combine_posts_users_models each_post;
  final users_models currentUser;

  const _PostFromOnePersonHeader({Key key, this.each_post, this.currentUser})
      : super(key: key);

  _PostFromOnePersonHeaderState createState() =>
      _PostFromOnePersonHeaderState(each_post: each_post, currentUser: currentUser);
}

class _PostFromOnePersonHeaderState extends State<_PostFromOnePersonHeader> {
  final combine_posts_users_models each_post;
  final users_models currentUser;

  _PostFromOnePersonHeaderState({
    Key key,
    @required this.each_post,
    @required this.currentUser,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: each_post.avatar.toString()),

        //avatar
        const SizedBox(width: 8.0),
        //khoảng cách từ avatar tới tên chủ thớt
        Expanded(
          //Expanded làm việc với Flex/Flexbox layout. Nó là một trong những widget tốt nhất để phân chia không gian giữa các items với nhau
          child: Column(
            //chủ thớt và (thời gian đăng, chế độ xem) được xếp dọc
            crossAxisAlignment: CrossAxisAlignment.start,
            //tên chủ thớt được đặt ở bên trái,
            children: [
              Text(
                each_post.name.toString(),
                //tên chủ thớt
                style: const TextStyle(
                  fontWeight: FontWeight.w600, //độ đậm
                ),
              ),
              Row(
                children: [
                  //thời gian đăng và chế độ xem được xếp ngang
                  Text(
                    '${each_post.time_post.toString()} • ',
                    //Thời gian đăng và dấu •
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    //chế độ xem
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),

        each_post.id_users.toString() == currentUser.id_users.toString() //chỉ đc sửa và xóa bài viết của mình thôi
            ?
        Row(
          children: [
            IconButton(
              //dấu mở rộng
                icon: const Icon(Icons.edit),
                onPressed: () {//Sang trang sửa bài viết


                  Navigator.push( //điều hướng sang màn hình mới (Màn hình HomeScreen)
                    context,  //điều hướng từ
                    MaterialPageRoute(  //điều hướng sang
                      //bên dưới cũng có hàm route sang NavScreen, nhưng route ở đây là route khi kiểm tra ngay từ đầu, nếu đã đăng nhập lần trước rồi thì route ngay
                        builder: (context) => EditPost(each_post: each_post, currentUser: currentUser) //chuyển sang home page chứa 6 cái màn hình
                    ),
                  );


                }
            ),
            IconButton(
              //dấu mở rộng
                icon: const Icon(Icons.delete),
                onPressed: () {
                  //gọi API xóa bài viết
                  delete_post.DeletePost(each_post.id_posts.toString());

                }
            ),
          ],
        )
            : Container()
        ,

      ],
    );
  }
}

//2. số lượng like, comment, share của status
class _PostFromOnePersonStats extends StatefulWidget {
  //phía head của status (chủ thớt, avatar, ngày đăng, các lưa chọn khác, chế độ xem,...)
  final combine_posts_users_models each_post;
  final users_models currentUser;

  const _PostFromOnePersonStats({Key key, this.each_post, this.currentUser})
      : super(key: key);

  _PostFromOnePersonStatsState createState() =>
      _PostFromOnePersonStatsState(each_post: each_post, currentUser: currentUser);
}

class _PostFromOnePersonStatsState extends State<_PostFromOnePersonStats> {
  final combine_posts_users_models each_post;
  final users_models currentUser;
  Future<IconData> icon;
  int likeqty = 0;
  bool isLoading;

  _PostFromOnePersonStatsState({
    Key key,
    @required this.each_post,
    @required this.currentUser,
  }) : super();

  @override
  void initState() {
    super.initState();
    icon = LikeController.CheckHasBeenLikedPostEvent(each_post.id_posts.toString(), currentUser.id_users.toString());
    likeqty = int.parse(each_post.likes_post.toString());
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return Column(
      //trả về 1 cột, trong 1 cột chứa 3 thành phần nằm ngang: like, cmt, share
      children: [
        FlatButton(
          onPressed: () => {
            Navigator.push( //điều hướng sang màn hình mới (Màn hình HomeScreen)
              context, //điều hướng từ
              MaterialPageRoute(
                  builder: (context) => ListLike(each_post: each_post)
              ),
            )
          },
          child: Row(
            children: [
              //nút like
              Container(
                padding: const EdgeInsets.all(4.0),
                //kích cỡ của hình bao quanh icon like
                decoration: BoxDecoration(
                  //hình bao quanh icon like
                  color: Palette.facebookBlue,
                  //hình bao quanh icon like có nền xanh
                  shape:
                  BoxShape.circle, //hình bao quanh icon like là hình tròn
                ),
                child: Icon(
                  Icons.thumb_up,
                  size: 10.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4.0),
              //khoảng cách từ icon like đến số like
              Expanded(
                //số like
                child: Text(
                  likeqty.toString(), //số like

                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(
                //số lượng comment

                each_post.comment_post.toString() + " Comments",

                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8.0),
              //khoảng cách giữa số comment và số lượt share
              Text(
                //số share
                each_post.shares_post.toString() + " Shares",

                style: TextStyle(
                  color: Colors.grey[600],
                ),
              )
            ],
          ),
        ),

        const Divider(), //giống như thẻ <hr>


        Row(
          children: [
            FutureBuilder(
              future: icon, //NẾU ĐÃ LIKE HAY CHƯA LIKE
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("--------------icon là = " + snapshot.data.toString());

                  return
                    _PostButton(
                        icon: Icon(
                          snapshot.data ,
                          color: Colors.grey[600],
                          size: 20.0, //kích cỡ của icon like
                        ),
                        label: 'Like',
                        onTap: () => {
                          setState(() {
                            if(isLoading == true){
                              Fluttertoast.showToast(
                                  msg: "Ấn chậm thôi :))",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            if(isLoading == false) {
                              isLoading = true;
                              icon = LikeController.HandleLikeButtonEvent(
                                  each_post.id_posts.toString(),
                                  currentUser.id_users
                                      .toString()); //xử lý sự kiện ấn nút like
                              snapshot.data == MdiIcons.thumbUp
                                  ? likeqty--
                                  : likeqty++;
                            }
                            icon.whenComplete(() => isLoading = false);
                          }),
                        });
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () => {
                //Xử lý sự kiện Comments: Hiển thị danh sách comment
                Navigator.push( //điều hướng sang màn hình mới (Màn hình HomeScreen)
                  context,  //điều hướng từ
                  MaterialPageRoute(
                      builder: (context) => ListComment(posts: each_post, currentUser: currentUser)
                  ),

                ),
                //Xử lý sự kiện Comments
              },
            ),
            _PostButton(
                icon: Icon(
                  MdiIcons.shareOutline,
                  color: Colors.grey[600],
                  size: 25.0,
                ),
                label: 'Share',
                onTap: () => {
                  print('Share'),
                  //Xử lý sự kiện ấn nút share

                  //Xử lý sự kiện ấn nút share
                })
          ],
        )
      ],
    );
  }
}

//3. 3 nút like, comment, share của status
class _PostButton extends StatelessWidget {
  //tham chiếu chung đến 3 nút like, comment, share của status
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //chia đều 3 khu vực cho 3 nút like, comment, share
      child: Material(
        color: Colors.white, //màu nền của dòng chứa 3 nút
        child: InkWell(
          onTap: onTap,
          //khi ấn vào thì sự kiện onTap sẽ xảy ra (được định nghĩa riêng)
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //khoảng cách từ 2 mép màn hình tới khung chứa icon like
            height: 25.0,
            //chiều cao của ô chứa nút like
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //vị trí của nút like là ở giữa (center)
              children: [
                icon,
                //logo "like"
                const SizedBox(width: 4.0),
                //khoảng cách giữa logo "like" và chữ "Like"
                Text(label),
                //chữ "Like"
              ],
            ),
          ),
        ),
      ),
    );
  }
}
