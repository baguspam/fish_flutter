import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/clip_circle.dart';
import '../widget/button_widget.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    getSharedPrefences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[400],
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            child: WaveShape(),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    minRadius: 35,
                                    maxRadius: 40,
                                    child: IconButton(
                                      iconSize: 45,
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color:Colors.blue[400],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: ListTile(
                            title: Text("Nama :", style: TextStyle(color: Colors.white),),
                            subtitle: Text(sharedPreferences?.get('sName'), style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color:Colors.blue[400],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: ListTile(
                            title: Text("Nomor HP :", style: TextStyle(color: Colors.white),),
                            subtitle: Text(sharedPreferences?.get('sPhone'), style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color:Colors.blue[400],
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: ListTile(
                            title: Text("Email :", style: TextStyle(color: Colors.white),),
                            subtitle: Text(sharedPreferences?.get('sEmail'), style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ButtonWidget(
                          title: "Logout",
                          hasBorder: true,
                          onTapFunction: () {
                            logout();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              ))),
    );
  }

   getSharedPrefences() async {
     await SharedPreferences.getInstance().then((value){
       setState(() {
         sharedPreferences = value;
       });
     });
   }
  logout() async {
    sharedPreferences =  await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }
}


