import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/fish.dart';
import '../utils/api.dart';
import './login_screen.dart';
import './profile_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  Future<List<FishModel>> fishList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fishList = _getFish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.
      white,
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.account_circle, size: 35, color: Colors.blue[400],),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileScreen()
                    ));
                    },
              ),
              IconButton(
                  icon: Icon(Icons.power_settings_new, size: 35, color: Colors.blue[400],),
                  onPressed: (){
                      logout();
                    },
              ),
              Column(
                children: <Widget>[
              FutureBuilder<List<FishModel>>(
                  future: fishList,
                  builder: (context, snapshot) {
                    List<FishModel> data = snapshot.data;
                    return
                      ListView.builder(
                          itemBuilder: (context, index) {
                            final FishModel fish = data[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (
                                    context) {
                                  return DetailScreen(fish: fish);
                                }));
                              },
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Image.asset("https://api-belajar.herokuapp.com"+fish.photo),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              fish.title,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(fish.category=="T"?"Ikan Air Tawar":"Ikan Air Laut"),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                  })
                ],
              )
            ],
          ),
        ),
    );
  }

  logout() async {
    sharedPreferences =  await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    toast("Logout Sukses");
  }

  toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<List<FishModel>> _getFish() async {
    setState(() {
      _isLoading = true;
    });
    Response response = await Api().getFish();
    setState(() {
      _isLoading = false;
    });
    if(response.statusCode == 200){
      return postModelFromJson(response.body);
    }else{
      throw "failed load to internet";
    }
  }
}
