import 'package:get/get.dart';

import 'blog_detail_screen_controller.dart';


class BlogDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlogDetailScreenController>(
      () => BlogDetailScreenController(),
    );
  }
}
