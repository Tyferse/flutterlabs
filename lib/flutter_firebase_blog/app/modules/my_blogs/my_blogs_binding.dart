import 'package:get/get.dart';

import 'my_blogs_controller.dart';


class MyBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBlogsController>(
      () => MyBlogsController(),
    );
  }
}
