
import 'dart:io';
import 'package:bai3/widgets/content.dart';
import 'package:bai3/widgets/home_screen.dart';
import 'package:bai3/widgets/homepage.dart';
import 'package:bai3/widgets/login.dart';
import 'package:bai3/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  Platform.isAndroid ?  // Đây là một cấu trúc điều kiện ternary kiểm tra xem ứng dụng đang chạy trên Android hay không. Nếu điều kiện đúng (ứng dụng đang chạy trên Android), hàm Firebase.initializeApp() sẽ được gọi với các tùy chọn cấu hình Firebase cho Android được cung cấp. Nếu không, chỉ cần gọi Firebase.initializeApp() mà không cần cung cấp bất kỳ tùy chọn nào.
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD5E-OoGnrGnbh1SAgbx1yzHas350hHhG8",
            appId: "1:415158374131:android:482fa7bee342caa1a37186",
            messagingSenderId: "415158374131",
            projectId: "n01-authentication-3ff6f"
        )
      ) : await Firebase.initializeApp();  //Đây là hàm được sử dụng để khởi tạo Firebase trong ứng dụng
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Authentication",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/register": (context) => MyRegister(),
        "/login": (context) => MyLogin(),
        "/content": (context) => HomeScreen(),
      },
    );
  }
}


