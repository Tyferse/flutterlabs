import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthenticationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  void isLoggedIn() {
    print('LogIn');
    if (_auth.currentUser != null) {
      Get.toNamed(Routes.home);
    }
    else {
      Get.toNamed(Routes.login);
    }
  }

  @override
  void onReady() {
    print('onReady');
    isLoggedIn();
    super.onReady();
  }
}
