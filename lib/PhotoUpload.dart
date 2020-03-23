import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoUpload extends StatefulWidget{
  @override
  _PhotoUpload createState() => new _PhotoUpload();
}

class _PhotoUpload extends State<PhotoUpload> {
  File _image;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: InkWell(
          onTap:_onAlertPress,
          child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage:  _image == null?
              AssetImage(
                  'assets/images/user_img_register.png'):
              FileImage(_image),
          ),
        ),
      ),
      ),
    );
  }


  void _onAlertPress() {
  }
}