import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get instance => null;

  Future<void> createAccount(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
    catch (e) {
      print(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch (e) {
      print(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut().whenComplete(() {
        Get.toNamed(Routes.login);
      });
    }
    catch (e) {
      print(e.toString());
    }
  }
}
