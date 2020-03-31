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
  String imagePath2 = "assets/images/user_img_register.png";
  String buttonText = "Save";
  AppState state;
  File _image;
  String _uploadedFileURL;

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
                      ? AssetImage(imagePath2)
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
              ),
              Text('Uploaded Image'),
              _uploadedFileURL != null
                  ? Image.network(
                      _uploadedFileURL,
                      height: 150,
                    )
                  : Container(),
            ],
          ),
        ));
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    getCameraImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: Text('Take Photo'),
                    ),
                  ),
                ),
                Divider(
                  height: 7,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    getGalleryImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: Text('Gallery'),
                    ),
                  ),
                ),
                Divider(
                  height: 7,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getCameraImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    setState(() {
      _image = image;
      _cropImage();
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    setState(() {
      _image = image;
      Navigator.pop(context);
      _cropImage();
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
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
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
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
//      String url;
//    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
//    url = dowurl.toString();
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setString('url', url);

      print("Successfull2");
      Fluttertoast.showToast(msg: "Image uploaded successfully");
      pr.hide();
    });
  }
}
