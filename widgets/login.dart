import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bai3/firebase_authentication/firebase_auth.dart';

class MyLogin extends StatelessWidget {
  FirebaseAuthService _auth = FirebaseAuthService();  // Tạo một đối tượng của lớp FirebaseAuthService, được sử dụng để thực hiện các chức năng xác thực của Firebase.
  final TextEditingController _emailController = TextEditingController(); //Khởi tạo một đối tượng TextEditingController để quản lý trường nhập liệu cho địa chỉ email.
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController(); // Thêm controller cho trường nhập lại mật khẩu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.login,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 8), // Khoảng cách giữa biểu tượng và tiêu đề
            Text(
              "ĐĂNG NHẬP",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black54.withOpacity(0.8),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/dn-page.jpg"), // Đường dẫn đến ảnh của bạn
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(  //Widget để người dùng nhập liệu cho email, mật khẩu và nhập lại mật khẩu. Sử dụng TextEditingController tương ứng để quản lý dữ liệu nhập vào.
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _retypePasswordController, // Sử dụng controller mới cho trường nhập lại mật khẩu
                  decoration: InputDecoration(
                    hintText: "Retype password",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_passwordController.text != _retypePasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Mật khẩu và nhập lại mật khẩu không khớp."),
                        ),
                      );
                      return;
                    }
                    User? user = await _auth.loginUserWithEmailAndPassword(
                      _emailController.text, _passwordController.text,
                    );

                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Đăng nhập thành công."),
                        ),
                      );

                      Navigator.of(context).popAndPushNamed("/content");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Có lỗi đăng nhập."),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "ĐĂNG NHẬP",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.4)), // Sử dụng màu nhạt của ảnh nền
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // Khoảng cách giữa nút đăng ký và nút đăng nhập
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "TRANG CHỦ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.4)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
