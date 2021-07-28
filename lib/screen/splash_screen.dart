import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
// local
import 'login_screen.dart';
import 'home_screen.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>isLoggedIn()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Text('Logo'),
          ),
        ),
    );
  }

  Future<Timer> startTimer(Duration duration) async{
    return Timer(duration, (){
      isLoggedIn();
    });
  }

  isLoggedIn() async {
    var sharedPreference = await SharedPreferences.getInstance();
    setState(() {
      var status = sharedPreference.get("value");
      if(status == 1){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }
    });
  }

}