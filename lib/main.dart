import 'package:flutter/material.dart';
import 'package:profile_upload/NewScreen.dart';
import 'package:profile_upload/PhotoProfileUpload.dart';

import 'PhotoUpload.dart';
import 'PhotoUpload.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhotoProfileUpload(),
    );
  }
}

