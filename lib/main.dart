import 'package:admin/constants.dart';
import 'package:admin/screens/login_screencheck.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCM9taDbUvEx7zHsIE0nClKDGFJONgz1_4",
          appId: "1:981898641979:web:fe076c3a1c229248fad21e",
          messagingSenderId: "981898641979",
          projectId: "imageupload-d5819"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E Waste Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        primarySwatch: Colors.blue,
      ),
      home: LoginCheckScreen(),
      builder: EasyLoading.init(),
    );
  }
}
