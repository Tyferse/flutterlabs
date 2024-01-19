import 'package:flutterlabs/flutter_firebase_blog/app/data/const.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_auth.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/indicator.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void onLogin() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      Indicator.showLoading();
      await _authentication.login(email.text, password.text).then((value) {
        Indicator.closeLoading();
        Get.toNamed(Routes.home);
      });
      // await FirebaseAuth.instance
      //     .signInWithEmailAndPassword(
      //   email: email.text,
      //   password: password.text,
      // )
      //     .then((UserCredential userCredential) {
      //   Indicator.closeLoading();
      //   Get.toNamed(Routes.home);
      // });
    }
    else {
      showAlert("Требуются заполеными все поля");
    }
  }
}
