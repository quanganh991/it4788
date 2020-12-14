import 'package:fakebook_homepage/controllers/login/login_controller.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/widgets/login/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fakebook_homepage/widgets/login/utilities/constants.dart';
import 'package:fakebook_homepage/screens/nav_screen.dart';
import 'package:fakebook_homepage/screens/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<users_models> currentUserHere;


  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoggedIn = false;
  User currentUser;

  @override
  void initState() {
    super.initState();
    //isSignedIn(); //hàm kiểm tra xem có đăng nhập hay ko
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) { //2 nút đăng nhập = fb và google
    //nút Facebook và GG chung
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0, //chiều rộng và chiều cao của cái khung chứa cả 2 nút
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent, //màu của bóng mờ
              offset: Offset(0, 2), //tọa độ làm mờ, lấy (0,0) làm tâm
              blurRadius: 8.0, //phân tán độ mờ (càng cao thì càng loãng)
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
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
                        'Fakebook',
                        style: TextStyle(
                          color: Colors.lightBlue,
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
                            child: TextFormField(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Không được để trống trường này';
                                }
                                return null;
                              },
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
                            child: TextFormField(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Không được để trống trường này';
                                }
                                return null;
                              },
                              controller: password,
                              obscureText: true,
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
                      //



                      // _buildForgotPasswordBtn(),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () =>
                              print('Forgot Password Button Pressed'),
                          padding: EdgeInsets.only(right: 0.0),
                          //cách lề phải bao nhiêu
                          child: Text(
                            'Quên mật khẩu?',
                            style: kLabelStyle,
                          ),
                        ),
                      ),
                      //


                      // _buildLoginBtn(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        //khoảng cách giữa nút ĐĂNG NHẬP và các thành phần trên, dưới với nó
                        width: double.infinity,
                        //chiều ngang của nút ĐĂNG NHẬP = matchparent
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () => {
                            print('Login Button Pressed'),
                            //gửi dữ liệu lên server
                            if(username.text.trim() != "" && password.text.trim() != null){
                              setState(() { //thay đổi trạng thái hiện tại của intent
                                currentUserHere = login_controller.HandleSignIn(
                                    username.text,
                                    password.text); //gọi hàm xử lý đăng nhập
                              })
                            }
                          },

                          padding: EdgeInsets.all(15.0),
                          //khoảng cách từ chữ ĐĂNG NHẬP đến 2 viền trên dưới của nút ĐĂNG NHẬP
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.blue,
                          child: currentUserHere == null ?
                          Text(
                            'ĐĂNG NHẬP',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
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

                                        Fluttertoast.showToast(
                                            msg: "Đăng nhập thành công",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );

                                        currentUserHere = null;
                                        return Text(
                                          'ĐĂNG NHẬP',
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
                                        currentUserHere = null;
                                        return Text(
                                          'ĐĂNG NHẬP',
                                          style: TextStyle(
                                            color: Color(0xFF527DAA),
                                            letterSpacing: 1.5,
                                            //Khoảng cách giữa cách chữ Đ, Ă, N, G, N, H, Ậ, P
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                          ),
                                        );; //xoay vòng xoay vòng
                                      }
                                    },
                                  ),
                                ]
                            ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => SignUpScreen())
                          )
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Chưa có tài khoản? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Đăng ký ngay',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //
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
