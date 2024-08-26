import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bai3/firebase_authentication/firebase_auth.dart';

class MyRegister extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.person_add,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 8), // Khoảng cách giữa biểu tượng và tiêu đề
            Text(
              "ĐĂNG KÝ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black54.withOpacity(0.8),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/dk-page.jpg"), // Đường dẫn đến ảnh của bạn
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    User? user = await _auth.registerUserWithEmailAndPassword(
                      _emailController.text, _passwordController.text,
                    );

                    if (user != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Đã đăng ký thành công."),
                        ),
                      );

                      Navigator.of(context).popAndPushNamed("/login");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Có lỗi đăng ký."),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "ĐĂNG KÝ",
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


