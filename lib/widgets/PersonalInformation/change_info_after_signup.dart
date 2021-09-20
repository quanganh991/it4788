import 'package:fakebook_homepage/controllers/Personal/change_personal_information.dart';

import 'package:fakebook_homepage/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakebook_homepage/widgets/login/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ChangeInfoScreen extends StatefulWidget {

  final users_models currentUser;

  const ChangeInfoScreen({Key key, this.currentUser}) : super(key: key);


  @override
  _ChangeInfoScreenState createState() => _ChangeInfoScreenState(currentUser: currentUser);
}

class _ChangeInfoScreenState extends State<ChangeInfoScreen> {

  final users_models currentUser;


  _ChangeInfoScreenState({Key key, this.currentUser}) : super();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController avatar = TextEditingController();
  TextEditingController cover_picture = TextEditingController();

  @override
  void initState() {
    super.initState();
    username.text = currentUser.username.toString();
    password.text = currentUser.password.toString();
    name.text = currentUser.name.toString();
    country.text = currentUser.country.toString();
    city.text = currentUser.city.toString();
    company.text = currentUser.company.toString();
    avatar.text = currentUser.avatar.toString();
    cover_picture.text = currentUser.cover_picture.toString();
  }

  getImage() async {
    const url = 'https://vi.imgbb.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  //màu nền của ứng dụng
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFF1F8FA),
                      Color(0xFFDDE9EB),
                      Color(0xFFCCDADD),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                //chiều cao của màn hình ứng dụng = matchparent
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  //cho phép cuộn màn hình
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    //khoảng cách từ body đến 2 mép dọc màn hình
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'CHANGE PERSONAL INFO',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      //



                      // _buildEmailTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //chữ email thẳng hàng với khung nhập tài khoản
                        children: <Widget>[
                          Text(
                            'Tài khoản/ Email',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          //chiều cao của khung nhập email
                          Container(
                            alignment: Alignment.centerLeft, //chữ Enter your Email nằm ở giữa, bên trái
                            decoration: kBoxDecorationStyle, //khung nhập email có viền trắng bao quanh
                            height: 60.0, //chiều cao của khung nhập email
                            child: TextField(
                              controller: username,
                              keyboardType: TextInputType.emailAddress, //Yêu cầu người dùng phải nhập email trong khung
                              style: TextStyle(
                                color: Colors.black, //màu chữ khi người dùng nhập vào thanh email
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                //cái khung nhập email
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                //vị trí của Chữ "Enter your Email" cách viền trên của khung nhập email bao nhiêu
                                prefixIcon: Icon(
                                  //cái phong bì bên trái khung nhập email
                                  Icons.email,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Tài khoản/ Email', //hint
                                hintStyle: kHintTextStyle, //hint
                              ),
                              onChanged: (text) { //khi nội dung trong ô "tài khoản" thay đổi
                                //username = text;
                              },
                            ),
                          ),
                        ],
                      ),
                      //
                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mật khẩu',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: password,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Mật khẩu',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Tên người dùng',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: name,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.people,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Tên người dùng',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Quốc Gia',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: country,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.public,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Quốc Gia',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Thành Phố',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: city,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Thành Phố',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nơi làm việc',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: company,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.account_balance,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Nơi làm việc',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Avatar',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: avatar,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.people,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Avatar',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),
                      // _buildPasswordTF(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cover Picture',
                            style: kLabelStyle,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextField(
                              controller: cover_picture,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.picture_in_picture_sharp,
                                  color: Colors.greenAccent,
                                ),
                                hintText: 'Cover Picture',
                                hintStyle: kHintTextStyle,
                              ),
                              onChanged: (text) {//khi nội dung trong ô "mật khẩu" thay đổi
                                //password = text;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        //khoảng cách từ khung nhập email đến khung nhập password là 30
                        height: 30.0,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.image, color: Colors.green,),
                              title: Text('Upload Image', style: TextStyle(fontWeight: FontWeight.w600),),
                              onTap: (){
                                getImage();
                              },
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        //khoảng cách giữa nút ĐĂNG NHẬP và các thành phần trên, dưới với nó
                        width: double.infinity,
                        //chiều ngang của nút ĐĂNG NHẬP = matchparent
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () => {
                            //gửi dữ liệu lên server
                            setState(() { //thay đổi trạng thái hiện tại của intent
                              // currentUserHere = signup_controller.HandleSignUp(
                              //     username.text, password.text, name.text, country.text, city.text, company.text); //gọi hàm xử lý đăng nhập
                            }),
                          },

                          padding: EdgeInsets.all(15.0),
                          //khoảng cách từ chữ ĐĂNG NHẬP đến 2 viền trên dưới của nút ĐĂNG NHẬP
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.lightBlue,
                          child:
                          FlatButton(

                              onPressed: () {
                                change_personal_information.ChangePersonalInformation(
                                    currentUser.id_users.toString(),
                                    username.text,
                                    password.text,
                                    name.text,
                                    currentUser.create_at.toString(),
                                    currentUser.push_token.toString(),
                                    country.text,
                                    city.text,
                                    company.text,
                                    avatar.text,
                                  cover_picture.text
                                );
                              },
                              child: Text(
                            'Change Info',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              letterSpacing: 1.5,
                              //Khoảng cách giữa cách chữ Đ, Ă, N, G, N, H, Ậ, P
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          )
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
