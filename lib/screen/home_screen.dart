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
  Future<List<FishModel>> fishList;

  @override
  void initState() {
    super.initState();
    fishList = _getFish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.account_circle, size: 32, color: Colors.white),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileScreen()
                    ));
                  },
                ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.power_settings_new, size: 32, color: Colors.white),
                  onPressed: (){
                    logout();
                  },
                ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                return RefreshIndicator(
                    onRefresh: _getFish,
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth <= 600) {
                          return FishListView(fishList: fishList, );
                        } else if (constraints.maxWidth <= 1200) {
                          return FishGridView(gridCount: 4, fishList: fishList);
                        } else {
                          return FishGridView(gridCount: 6, fishList: fishList);
                        }
                      }),
                  );
                },
              ),
        ));

  }

  logout() async {
    SharedPreferences sharedPreferences=  await SharedPreferences.getInstance();
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
    Response response = await Api().getFish();
    print(response);
    if(response.statusCode == 200){
      return fishModelFromJson(response.body);
    }else{
      throw "failed load to internet";
    }
  }
}


class FishGridView extends StatelessWidget {
  final int gridCount;
  final Future<List<FishModel>> fishList;
  const FishGridView({Key key, @required this.gridCount,  @required this.fishList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<FishModel>>(
        future: fishList,
        builder: (context, snapshot) {
          List<FishModel> data = snapshot.data;
          return
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index) {
                  return Card(
                        elevation: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                "https://api-belajar.herokuapp.com" + data[index].photo,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                data[index].title,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: Text(
                                  data[index].category == "T"
                                      ? "Ikan Air Tawar"
                                      : "Ikan Air Laut")
                              ),
                          ],
                        ),
                      );
              });
        }),
      ),
    );
  }

}

class FishListView extends StatelessWidget {
  final Future<List<FishModel>> fishList;
  const FishListView({Key key, @required this.fishList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder<List<FishModel>>(
              future: fishList,
              builder: (context, snapshot) {
                List<FishModel> data = snapshot.data;
                return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailScreen(fishData: data[index]);
                                }));
                          },
                          child: Card(
                            elevation: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                      "https://api-belajar.herokuapp.com" +
                                          data[index].photo),
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
                                          data[index].title,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(data[index].category == "T"
                                            ? "Ikan Air Tawar"
                                            : "Ikan Air Laut"),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
              }),
          ),
    );
  }

}

