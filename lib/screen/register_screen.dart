import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/config.dart';
import '../widget/text_field_widget.dart';
import '../widget/button_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Container(
            alignment: Alignment.center,
            child: ScrollConfiguration(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFieldWidget(
                          textController: cName,
                          hintText: "Nama Lengkap",
                          obscureText: false,
                          prefixIconData: Icons.account_circle,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                          textController: cEmail,
                          hintText: "Email",
                          obscureText: false,
                          prefixIconData: Icons.email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFieldWidget(
                          textController: cPhone,
                          hintText: "Nomor HP",
                          obscureText: false,
                          prefixIconData: Icons.phone,
                        ),
                        SizedBox(
                          height: 15,
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
                          title: "Register",
                          onTapFunction: () {
                            submitDataRegister();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ButtonWidget(
                          title: "Back to Login",
                          hasBorder: true,
                          onTapFunction: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  submitDataRegister() async {
    if(cName.text !="" && cEmail.text != ""  && cPassword.text !="" && cPhone.text !="") {
      final responseData = await http.post(urlRegister,
          body: {
            "fullname": cName.text,
            "email": cEmail.text,
            "password": cPassword.text,
            "number_phone": cPhone.text,
          });

      final data = jsonDecode(responseData.body);
      print(data[0]["email"][0]);
      if (responseData.statusCode == 201) {
        toast("Registrasi Berhasil");
      } else if (responseData.statusCode == 400) {
        if(data[0]["email"][0] !=null){
          toast(data[0]["email"][0]);
        }else {
          toast("Sever sedang maintenace");
        }

      } else {
        toast("Koneksi Error");
      }
    }else{
      toast("Inputan tidak boleh kosong");
    }
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