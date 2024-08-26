import 'package:bai3/widgets/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(  //được sử dụng để lắng nghe sự thay đổi trong trạng thái xác thực của người dùng.
      stream: FirebaseAuth.instance.authStateChanges(), // Đây là nơi mà StreamBuilder lắng nghe các sự kiện trạng thái xác thực từ FirebaseAuth. Khi trạng thái xác thực thay đổi, một sự kiện sẽ được phát ra thông qua luồng này.
      builder: (context, snapshot) { //Đây là hàm xây dựng của StreamBuilder
        if (snapshot.hasData) { //Đây là điều kiện kiểm tra xem có dữ liệu người dùng hiện tại không. Nếu có, tức là người dùng đã đăng nhập và màn hình chính sẽ hiển thị.
          return MyHomePage();
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 8), // Khoảng cách giữa biểu tượng và tiêu đề
                  Text(
                    "THE DOG CUTE",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.black54.withOpacity(0.8),
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/home-page.jpg"), // Thay đổi đường dẫn của hình ảnh
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).popAndPushNamed("/register"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
                          Text(
                            "ĐĂNG KÝ",
                            style: TextStyle(
                              fontSize: 33,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0.5), // Sử dụng màu nhạt của màu chính của hình nền
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).popAndPushNamed("/login"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
                          Text(
                            "ĐĂNG NHẬP",
                            style: TextStyle(
                              fontSize: 33,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0.5), // Sử dụng màu nhạt của màu chính của hình nền
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}


