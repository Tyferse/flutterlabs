import 'package:flutterlabs/flutter_firebase_blog/app/data/const.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_auth.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_functions.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  final FirebaseFunctions _functions = FirebaseFunctions();
  final TextEditingController full_name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void onCreateAccount() async {
    if (full_name.text.isNotEmpty
        && email.text.isNotEmpty
        && password.text.isNotEmpty) {
      Indicator.showLoading();

      await _authentication.createAccount(email.text, password.text)
          .then((value) {
            _functions.createUserCredential(full_name.text, email.text, password.text);
          });
    }
    else {
      showAlert("Требуется заполнить все поля");
      print("Все поля должны быть заполнены");
    }
  }
}
