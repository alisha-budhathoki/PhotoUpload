import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';


class PhotoProfileUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData.light().copyWith(primaryColor: Colors.teal),
      home: MyProfilePage(
        title: 'ImageCropper',
      ),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  final String title;

  MyProfilePage({this.title});

  @override
  _MyProfilePage createState() => _MyProfilePage();
}
enum AppState {
  free,
  picked,
  cropped,
}

class _MyProfilePage extends State<MyProfilePage> {
  AppState state;
  File imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
    ),
    body:Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40,),
          InkWell(
            onTap: (){
                _onAlertPress();

            },
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage:  imageFile == null?
              AssetImage(
                  'assets/images/user_img_register.png'):
              FileImage(imageFile),
            ),
          ),
          SizedBox(height: 10,),
          Text('Harry Hanks',style: TextStyle(fontSize: 20),)
        ],
      ),
    )


    );
  }

  void _onAlertPress() async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            actions: [
              Column(
                children: <Widget>[
                  InkWell(child: Container(child: Text('Gallery',)),onTap: getGalleryImage,),
                  InkWell(child: Text('Take Photo'), onTap: getCameraImage,)

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
      if(state == AppState.picked){
        _cropImage();
      }

    }
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;

      });
      if(state == AppState.picked){
        _cropImage();
      }
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }
}


