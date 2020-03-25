import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'PhotoProfileUpload.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreen createState() => new _NewScreen();
}

class _NewScreen extends State<NewScreen> {
  AppState state;
  File imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          elevation: 15,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/images/back2.png')),
              Text(
                'Edit Profile',
                style: TextStyle(color: Colors.black),
              ),
              Text('         ')
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageFile != null ? Image.file(imageFile) : Image.asset(
              'assets/images/user_img_register.png',
              fit: BoxFit.fill,
            ),

            RaisedButton(
              onPressed: () {
                if (state == AppState.free) _onAlertPress();
              },
              child: Text('Click'),
            )
          ],
        ),
      ),
    );
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            actions: [
              Column(
                children: <Widget>[
                  InkWell(
                    child: Container(
                        child: Text(
                      'Gallery',
                    )),
                    onTap: getGalleryImage,
                  ),
                  InkWell(
                    child: Text('Take Photo'),
                    onTap: getCameraImage,
                  )
                ],
              ),
            ],
          );
        });
  }

  Future getCameraImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

//============================== Image from gallery
  Future getGalleryImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }
}
