import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './home_screen.dart';
import '../model/fish.dart';

class DetailScreen extends StatefulWidget {
  final FishModel fish;
  const DetailScreen({Key key, this.fish}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: IconButton(
        icon: Icon(Icons.account_circle, size: 35, color: Colors.blue[400],),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeScreen()
          ));
        },
      ),
    );
  }
}
