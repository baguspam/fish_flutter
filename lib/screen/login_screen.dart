import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../config/config.dart';
import '../widget/button_widget.dart';
import '../widget/text_field_widget.dart';
import './home_screen.dart';
import './register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _loading = false;

  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  final String email = "admin@gmail";
  final String password = "1234567";

  @override
  void initState() {
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Container(
            alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         Text("Login Ikan",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                               color: Colors.blue,
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                           )),
                          SizedBox(
                            height: 50,
                          ),
                          TextFieldWidget(
                            textController: cEmail,
                            hintText: "Email",
                            obscureText: false,
                            prefixIconData: Icons.email,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFieldWidget(
                                textController: cPassword,
                                hintText: "Password",
                                obscureText: true,
                                prefixIconData: Icons.lock,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ButtonWidget(
                            isLoading: _loading,
                            title: "Login",
                            onTapFunction: () {
                              _loading = true;
                              submitDataLogin();
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          ButtonWidget(
                            title: "Register",
                            hasBorder: true,
                            onTapFunction: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          )),
    );
  }

  submitDataLogin() async {
    setState(() {
      _loading = true;
    });

    try {
      await http.post(urlLogin, body: {
        "email": cEmail.text,
        "password": cPassword.text,
      }, headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      }).then((Response value) {
        var response = jsonDecode(value.body);
        if (value.statusCode == 201) {
          //simpan data login
          final dataFullname = response[0]["fullname"];
          final dataEmail = response[0]["email"];
          final dataPhone = response[0]["number_phone"];
          final dataLevel = response[0]["level"];
          _setDataPref(
              name: dataFullname,
              email: dataEmail,
              phone: dataPhone,
              level: dataLevel
          ).then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            toast("Login berhasil");
          });
        } else {
          toast("Email atau password Anda salah");
        }
      });
    } on SocketException {
      toast("No Internet Connection");
      setState(() {
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _setDataPref({ String name, String email, String phone, String level}) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    setState(() {
      sharedPreference.setInt("value", 1);
      sharedPreference.setString("sName", name);
      sharedPreference.setString("sEmail", email);
      sharedPreference.setString("sPhone", phone);
      sharedPreference.setString("sLevel", level);
    });
  }

  isLogin() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    setState(() {
      int status = sharedPreference.get("value");
      if(status == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    });
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue[400],
        textColor: Colors.white,
        fontSize: 16.0);
  }

}