import "package:firebase_auth/firebase_auth.dart";

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;  //Tạo một đối tượng _auth của lớp FirebaseAuth để thực hiện các chức năng xác thực.

  Future<User?> registerUserWithEmailAndPassword(String strEmail, String strPassword) async {  // : Phương thức này được sử dụng để đăng ký người dùng mới bằng email và mật khẩu. Nó trả về một Future<User?>, cho biết kết quả của quá trình đăng ký.
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: strEmail, password: strPassword);  // Sử dụng _auth để gọi phương thức createUserWithEmailAndPassword để đăng ký người dùng mới với email và mật khẩu được cung cấp.
      return credential.user;
    } catch (err) {
      print("Co loi tao user: $err");
    }
  }

  Future<User?> loginUserWithEmailAndPassword(String strEmail, String strPassword) async {  // Phương thức này được sử dụng để đăng nhập người dùng bằng email và mật khẩu. Nó trả về một Future<User?>, cho biết kết quả của quá trình đăng nhập.
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: strEmail, password: strPassword);
      return credential.user;
    } catch (err) {
      print("Co loi dang nhap: $err");
    }
  }

  Future<void> signOut() async {  // Phương thức này được sử dụng để đăng xuất người dùng hiện tại. Nó không trả về bất kỳ giá trị nào, chỉ thực hiện hành động đăng xuất.
    try {
      await _auth.signOut();  // Sử dụng _auth để gọi phương thức signOut để đăng xuất người dùng hiện tại.
    } catch (err) {
      print("Co loi dang xuat: $err");
    }
  }
}