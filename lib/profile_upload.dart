import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:profile_upload/after_uploading.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpload extends StatefulWidget {

  @override
  _MyProfilePage createState() => _MyProfilePage();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _MyProfilePage extends State<ProfileUpload> {
  AppState state;
  File _image;


  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text('Hello world')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  _onAlertPress();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: _image == null
                      ? AssetImage('assets/images/user_img_register.png')
                      : FileImage(_image),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Harry Hanks',
                style: TextStyle(fontSize: 20),
              ),
              RaisedButton(
                onPressed: uploadImage,
                color: Colors.teal,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                //onPressed: uploadImage
              )
            ],
          ),
        ));
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
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      Navigator.pop(context);
      _cropImage();
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      Navigator.pop(context);
                _cropImage();

//      if(_image != null){
//        setState(() {
//          state = AppState.picked;
//        });
//        if (state == AppState.picked) {
//          _cropImage();
//        }
//      }
    });
  }
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
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
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  Future uploadImage() async {
    ProgressDialog pr;
    pr = new ProgressDialog(context);
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
    );
    pr.show();

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_image/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String url;
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('url', url);

    print("Successfull2");
      Fluttertoast.showToast(msg: "Image uploaded successfully");
      pr.hide();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AfterUploading(),
          ));
  }
}
