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
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<users_models> currentUserHere;
  bool isLoggedIn = false;

  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName); //"myFile.json"
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
                () => {
                  fileContent = json.decode(jsonFile.readAsStringSync()),
                }
        );
      currentUserHere = login_controller.CheckAutoLogin(fileContent);

    });
    //print("---------------fileContent = " + fileContent.toString());
  }

  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
    print("----------------------Creating file!----------------------");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, dynamic value) {
    print("----------------------Writing to file!----------------------");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("----------------------File exists----------------------");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("----------------------File does not exist!----------------------");
      createFile(content, dir, fileName); //"myFile.json"
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));  //đọc nội dung json sau khi đã thêm
    print(fileContent); //in nội dung ra
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
                                          writeToFile("id_users", snapshot.data.id_users.toString());
                                          writeToFile("username", snapshot.data.username.toString());
                                          writeToFile("password", snapshot.data.password.toString());
                                          writeToFile("name", snapshot.data.name.toString());
                                          writeToFile("create_at", snapshot.data.create_at.toString());
                                          writeToFile("push_token", snapshot.data.push_token.toString());
                                          writeToFile("country", snapshot.data.country.toString());
                                          writeToFile("city", snapshot.data.city.toString());
                                          writeToFile("company", snapshot.data.company.toString());
                                          writeToFile("avatar", snapshot.data.avatar.toString());
                                          writeToFile("cover_picture", snapshot.data.cover_picture.toString());

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
