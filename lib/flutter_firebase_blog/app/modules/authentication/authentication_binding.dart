import 'package:get/get.dart';

import 'authentication_controller.dart';


class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationController>(
      AuthenticationController(),
    );
  }
}
