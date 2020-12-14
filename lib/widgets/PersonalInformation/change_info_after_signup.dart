import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/controllers/login/login_controller.dart';
import 'package:fakebook_homepage/controllers/login/signup_controller.dart';

import 'package:fakebook_homepage/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakebook_homepage/widgets/login/utilities/constants.dart';
import 'package:fakebook_homepage/screens/nav_screen.dart';
import 'package:fakebook_homepage/screens/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeInformation extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ChangeInformation> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();


  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController company = TextEditingController();

  Future<users_models> currentUserHere;


  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoggedIn = false;
  User currentUser;

  @override
  void initState() {
    super.initState();
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
                      Color(0xFF65E6FF),
                      Color(0xFF00B4FF),
                      Color(0xFF0084FF),
                      Color(0xFF0D26EA),
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
                        'ĐĂNG KÝ',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
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
                                color: Colors.white, //màu chữ khi người dùng nhập vào thanh email
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
                                color: Colors.white,
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
                                color: Colors.white,
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
                                color: Colors.white,
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
                                color: Colors.white,
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
                                color: Colors.white,
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

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        //khoảng cách giữa nút ĐĂNG NHẬP và các thành phần trên, dưới với nó
                        width: double.infinity,
                        //chiều ngang của nút ĐĂNG NHẬP = matchparent
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () => {
                            print('SignUp Button Pressed'),
                            //gửi dữ liệu lên server
                            setState(() { //thay đổi trạng thái hiện tại của intent
                              currentUserHere = signup_controller.HandleSignUp(
                                  username.text, password.text, name.text, country.text, city.text, company.text); //gọi hàm xử lý đăng nhập
                            }),
                          },

                          padding: EdgeInsets.all(15.0),
                          //khoảng cách từ chữ ĐĂNG NHẬP đến 2 viền trên dưới của nút ĐĂNG NHẬP
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: currentUserHere == null ?
                          Text(
                            'ĐĂNG KÝ',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              //Khoảng cách giữa cách chữ Đ, Ă, N, G, N, H, Ậ, P
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          )
                              :
                          Column(
                              children: <Widget>[
                                FutureBuilder<users_models>(
                                  future: currentUserHere, //chờ khi nào giá trị này khác null thì đoạn này mới đc thực hiện //Album _futureAlbum = new Album();
                                  builder: (context, snapshot) {  //snapshot = _futureAlbum
                                    if (snapshot.hasData && snapshot.data.id_users != null) {
                                      WidgetsBinding.instance.addPostFrameCallback((_){
                                        Navigator.push( //điều hướng sang màn hình mới (Màn hình HomeScreen)
                                          context,  //điều hướng từ
                                          MaterialPageRoute(  //điều hướng sang
                                            //bên dưới cũng có hàm route sang NavScreen, nhưng route ở đây là route khi kiểm tra ngay từ đầu, nếu đã đăng nhập lần trước rồi thì route ngay
                                              builder: (context) => NavScreen(currentUser: snapshot.data) //chuyển sang home page chứa 6 cái màn hình
                                          ),
                                        );
                                      });
                                      currentUserHere = null;
                                      Fluttertoast.showToast(
                                          msg: "Đăng ký thành công, đang đăng nhập",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      return Text(
                                        'ĐĂNG KÝ',
                                        style: TextStyle(
                                          color: Color(0xFF527DAA),
                                          letterSpacing: 1.5,
                                          //Khoảng cách giữa cách chữ Đ, Ă, N, G, N, H, Ậ, P
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans',
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      currentUserHere = null;
                                      return Text("${snapshot.error}");
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Tài khoản đã tồn tại hoặc không hợp lệ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      currentUserHere = null;
                                      return Text(
                                        'ĐĂNG KÝ',
                                        style: TextStyle(
                                          color: Color(0xFF527DAA),
                                          letterSpacing: 1.5,
                                          //Khoảng cách giữa cách chữ Đ, Ă, N, G, N, H, Ậ, P
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ); //xoay vòng xoay vòng
                                    }
                                  },
                                ),
                              ]
                          ),
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
