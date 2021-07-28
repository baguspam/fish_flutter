import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;

  TextFieldWidget(
      {this.textController,
        this.hintText,
        this.prefixIconData,
        this.suffixIconData,
        this.obscureText,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      obscureText: obscureText,
      onChanged: onChanged,
      style: TextStyle(
          color: Colors.black
      ),
      cursorColor: Colors.blue,
      decoration: InputDecoration(
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.blue),
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(
              prefixIconData,
              size: 18,
              color: Colors.blue),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue)
          )
      ),
    );
  }
}