import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skl/homeScreen/homePage.dart';
import 'package:skl/registerAndLogin/SignupPage.dart';
import 'package:skl/registerAndLogin/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for Android
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
    options: const FirebaseOptions(
    apiKey: 'AIzaSyC2nkhp_d_YDnfmI75FguNPkMMuyx8j0og',
    appId: '1:250476651920:android:107e476027b7dd0694ff15',
    messagingSenderId: '250476651920',
    projectId: 'sellkroindia-677a3',
    storageBucket: 'sellkroindia-677a3.appspot.com',
      ),
    );
  } 
  // Initialize Firebase for iOS
  else if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCyaCe9CRs_zlD3Yj74buECbICPIAdU38Y',
    appId: '1:250476651920:ios:288627afec3af7de94ff15',
    messagingSenderId: '250476651920',
    projectId: 'sellkroindia-677a3',
    storageBucket: 'sellkroindia-677a3.appspot.com',
    iosBundleId: 'com.example.skl',
      ),
    );
  }

  // Check if the user has already signed up
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Signup',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomePage(adCount: 50,) : SignupPage(), // Show HomePage if logged in, otherwise show SignupPage
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(adCount: 50,), // Replace with your home page widget
      },
    );
  }
}
