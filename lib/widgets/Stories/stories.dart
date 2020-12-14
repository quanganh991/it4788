
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/Stories/stories_controller.dart';
import 'package:fakebook_homepage/models/combine_stories_users_models.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:fakebook_homepage/models/users_models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';
import 'package:fakebook_homepage/widgets/widgets.dart';

class Stories extends StatefulWidget {
  final users_models currentUser;
  const Stories({Key key, this.currentUser}) : super(key: key);

  _StoriesState createState() => _StoriesState(currentUser: currentUser);
}

class _StoriesState extends State<Stories>{

  final users_models currentUser;
  Future<List<combine_stories_users_models>> allStories;

  _StoriesState({
    Key key,
    @required this.currentUser,
  }) : super();

  @override
  void initState() {
    super.initState();
    allStories = stories_controller.GetAllStories(currentUser.id_users.toString());
  }

  @override
  Widget build(BuildContext context) {
    //print("----------------stories!!!");

    return FutureBuilder(
      future: allStories, //lấy ra số stories trong db
      builder: (context, snapshot) {
        print("----------------snapshot.hasData = " + snapshot.hasData.toString());

        if (snapshot.hasData) {

          return Container(
            height: 200.0,
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 8.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 1 + snapshot.data.length,
              //list view này có nhiều hơn mảng stories là 1 phần tử (tính cả add to story)
              itemBuilder: (BuildContext context, int index) {
                //
                //duyệt tất cả các story trong csdl

                if (index == 0) {

                  //dành vị trí đầu tiên (0) cho chức năng "Add to Story"
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    //khoảng cách từ "Add to Story" đến viền bên trái của khung chứa Story
                    child:
                    _StoryCard(
                      //story của người đăng nhập
                      currentUser: currentUser,
                      isAddStory: true, //bắt buộc phải là true
                      indexStories: -1, //bên trong ảnh Add to story là người dùng hiện tại
                    ),
                  );
                }
                //duyệt đến item thứ mấy trong listview, thì "thứ mấy" sẽ chứa ảnh của phần tử trước nó 1 vị trí trong mảng stories
                else {
                  print("---------------index stories = " + (index - 1).toString());
                  return Padding(
                    //story của bạn bè của người đăng nhập
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    //Khoảng cách giữa 2 story cạnh nhau

                    child:
                    _StoryCard(
                        currentUser: currentUser,
                        indexStories: index - 1,
                        isAddStory: false
                    ), //stories của bẹn bè của người đang đăng nhập
                  );
                }

              },
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _StoryCard extends StatefulWidget {
  //Cụ thể về các story của mọi người
  final bool isAddStory;
  final int indexStories;
  final users_models currentUser;
  const _StoryCard({Key key, this.currentUser, this.isAddStory = false, this.indexStories}) : super(key: key);

  _StoriesCardState createState() => _StoriesCardState(currentUser: currentUser, isAddStory: isAddStory, indexStories: indexStories);
}

class _StoriesCardState extends State<_StoryCard>{

  final bool isAddStory;
  final int indexStories;
  final users_models currentUser;

  Future<List<combine_stories_users_models>> allStories;

  _StoriesCardState({ //khởi tạo thì isAddStory = false
    Key key,
    this.isAddStory = false,
    this.indexStories,
    this.currentUser,
  }) : super();

  @override
  void initState() {
    super.initState();
    allStories = stories_controller.GetAllStories(currentUser.id_users.toString());
    //print("----------------indexd  = " + currentUser.id_users.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: allStories,
        builder: (context, snapshot) {
          print("----------------snapshot.hasData _StoriesCardState = " + snapshot.hasData.toString());

          if (snapshot.hasData) {     //duyệt từng stories
            return Stack( //đè nhau
              children: [
                    ClipRRect( //Mảng chứa các story của tất cả bạn bè và avatar của người dùng đang đăng nhập
                          //ảnh story
                          borderRadius: BorderRadius.circular(12.0),
                          //Độ cong của 4 góc chữ nhật của ảnh trong story (ban đầu là 1 hình chữ nhật vuông 4 góc)
                          child: CachedNetworkImage(
                            //hình ảnh trong story
                            // imageUrl: isAddStory ? currentUser.imageUrl : story.imageUrl, //ban đầu kiểm tra xem ảnh đó có phải là AddStory hay không
                            imageUrl: (
                                isAddStory
                                ?
                            currentUser.avatar.toString() //ADD TO STORY
                                :
                                snapshot.data[indexStories].photo_url.toString()  //SAU ĐÓ TRỞ ĐI
                            ),  //story của bạn bè
                            height: double.infinity,
                            //chiều cao của ảnh trong story matchParent với chiều cao của mỗi story
                            width: 110.0,
                            //chiều rộng của mỗi ảnh trong story
                            fit: BoxFit
                                .cover, //làm cho ảnh trong story vừa khớp với cả story
                          ),
                        ),

                Container(
                  //khung chứa story
                  height: double.infinity,
                  width: 110.0,
                  decoration: BoxDecoration(
                    gradient: Palette.storyGradient,
                    //khung chứa story hơi xám xám 1 chút
                    borderRadius: BorderRadius.circular(12.0),
                    //Độ cong của 4 góc chữ nhật của khung story (ban đầu là 1 hình chữ nhật vuông 4 góc)
                    boxShadow: null,
                  ),
                ),



                          Positioned(//avatar của bạn bè đăng story hay dấu +
                            top: 8.0,
                            left: 8.0,
                            child: isAddStory
                                ? Container(
                              //hiện ra logo Add to Story và ảnh trong story chính là avatar
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                //hình dấu + để add story
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add),
                                  iconSize: 30.0,
                                  color: Palette.facebookBlue,
                                  onPressed: () => {
                                    print('Add to Story'),
                                  }),
                            )
                                :
                            ProfileAvatar(
                              //hiện ra các avatar của các người khác

                              imageUrl: snapshot.data[indexStories].avatar.toString(), // các avatar của các bạn bè đăng story khác

                              hasBorder: true, //chưa xem thì có viền xanh, xem rồi thì không
                            ),
                          ),








                          Positioned( //tên của người đăng story hay chữ "Add story" màu trắng, phía dưới
                            bottom: 8.0,
                            //Vị trí tương đối của chữ trắng bên dưới story so với ảnh trong story
                            left: 8.0,
                            right: 8.0,
                            child: Text(
                              isAddStory
                                  ? 'Add to Story'
                                  : snapshot.data[indexStories].name.toString(),

                              //tên của người đăng story

                              //ảnh AddtoStory thì có chữ 'Add to Story' phía dưới, trái lại thì là tên bạn bè đã đăng story

                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              //nếu tên vượt quá maxLines dòng thì sẽ xử lý phụ thuộc vào overflow
                              overflow: TextOverflow
                                  .ellipsis, //xử lý khi tên dài tràn ra khỏi story: thêm dấu ... vào sau tên nào dài quá, nếu không chữ sẽ bị cắt bớt đi
                            ),
                          )


              ],
            );
          }
          return CircularProgressIndicator();
        });
  }
}
