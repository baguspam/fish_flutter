import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import './home_screen.dart';
import '../model/fish.dart';

class DetailScreen extends StatelessWidget {
  final FishModel fishData;
  const DetailScreen({Key key, @required this.fishData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebScreen(fishList: fishData);
        } else {
          return DetailMobileScreen(fishList: fishData);
        }
      },
    );
  }
}


class DetailMobileScreen extends StatelessWidget {
  final FishModel fishList;
  const DetailMobileScreen({Key key, @required this.fishList}) : super(key: key);

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
                      Image.network("https://api-belajar.herokuapp.com" + fishList.photo,
                        fit: BoxFit.cover,
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
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
              ],
          ),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text(
                      fishList.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child:  Text(
                      fishList.category == "T" ? "Ikan Air Tawar" : "Ikan Air Laut",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.0, left: 10, right: 10),
                      child: Html(data: fishList.description,
                        style: {"p":Style(textAlign: TextAlign.justify,margin: EdgeInsets.only(top:5))},
                      )
                  ),
        ]),
      ))),
    );
  }

}

class DetailWebScreen extends StatelessWidget {
  final FishModel fishList;
  const DetailWebScreen({Key key, @required this.fishList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb ? null : AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64,),
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width <= 1200 ? 800 : 1200,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.network("https://api-belajar.herokuapp.com" + fishList.photo,
                            fit: BoxFit.cover,
                          ),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
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
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: Text(
                          fishList.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child:  Text(
                            fishList.category == "T" ? "Ikan Air Tawar" : "Ikan Air Laut",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5.0, left: 10, right: 10),
                          child: Html(data: fishList.description,
                            style: {"p":Style(textAlign: TextAlign.justify,margin: EdgeInsets.only(top:5))},
                          )
                      ),
                    ]),
              ))),
    );
  }

}

