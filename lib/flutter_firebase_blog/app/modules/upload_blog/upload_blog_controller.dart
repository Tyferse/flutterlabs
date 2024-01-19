import 'package:flutterlabs/flutter_firebase_blog/app/data/const.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_functions.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/indicator.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/modules/my_blogs/my_blogs_controller.dart';
// import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
// import 'package:flutterlabs/flutter_firebase_blog/app/modules/my_blogs/controllers/my_blogs_controller.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../home/home_controller.dart';


class UploadBlogController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  FirebaseFunctions _functions = FirebaseFunctions();
  HomeController? homeController;
  MyBlogsController? myBlogsController;

  UploadBlogController() {
    homeController = Get.find<HomeController>();
    myBlogsController = Get.find<MyBlogsController>();
  }

  void createBlog() async {
    if (title.text.isNotEmpty && description.text.isNotEmpty) {
      Indicator.showLoading();

      await _functions.uploadBlog(title.text, description.text).then((value) {
        if (homeController != null) {
          homeController!.getData();
        }

        if (myBlogsController != null) {
          myBlogsController!.getMyBlogData();
        }

        Indicator.closeLoading();
        showAlert("Пост создан успешно");
        Get.toNamed(Routes.my_blogs);
      });
    }
    else {
      showAlert("Требуются заполнеными все поля");
    }
  }
}
