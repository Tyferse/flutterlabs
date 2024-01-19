import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_functions.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/indicator.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
// import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';


class MyBlogsController extends GetxController {
  final FirebaseFunctions _functions = FirebaseFunctions();
  final HomeController homeController = Get.find<HomeController>();
  List blogs_id = [];
  List<BlogsModel> my_blogs = [];

  void getMyBlogData() async {
    blogs_id = await _functions.getMyBlogs();

    if (blogs_id.isNotEmpty) {
      my_blogs.clear();
      for (var i = 0; i < blogs_id.length; i++) {
        BlogsModel model = await _functions.getBlogsById(blogs_id[i]);
        my_blogs.add(model);
      }
    }

    update();
    Indicator.closeLoading();
  }

  void deleteBlog(String id) async {
    Indicator.showLoading();
    await _functions.deleteBlog(id);
    homeController.blogs.removeWhere((element) => element.id == id);
    update();
    Indicator.closeLoading();
  }


  @override
  void onReady() {
    super.onReady();
    Indicator.showLoading();
  }

  @override
  void onInit() {
    super.onInit();
    getMyBlogData();
  }

  // void getMyBlogData() async {
  //   blogs_id = await _functions.getMyBlogs();
  //
  //   if (blogs_id.isNotEmpty) {
  //     for (var i = 0; i < blogs_id.length; i++) {
  //       BlogsModel model = await _functions.getBlogsById(blogs_id[i]);
  //       // print(model.id);
  //       // print("${model.id} | ${model.title} | ${model.description}");
  //       my_blogs.add(model);
  //     }
  //   }
  //
  //   // print("${my_blogs[0].id} | ${my_blogs[0].title} | ${my_blogs[0].description}");
  //   update();
  //   Indicator.closeLoading();
  // }
  //
  // void deleteBlog(String id) async {
  //   Indicator.showLoading();
  //   await _functions.deleteBlog(id).then((value) {
  //     my_blogs = [];
  //     getMyBlogData();
  //   });
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  //   Indicator.showLoading();
  // }
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   getMyBlogData();
  // }
}
