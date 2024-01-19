import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../my_blogs/my_blogs_controller.dart';
import 'upload_blog_controller.dart';


class UploadBlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadBlogController>(() => UploadBlogController(),);
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MyBlogsController>(() => MyBlogsController());
  }
}
