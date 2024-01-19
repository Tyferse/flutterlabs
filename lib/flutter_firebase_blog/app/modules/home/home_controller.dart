import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_functions.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/indicator.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  final FirebaseFunctions _functions = FirebaseFunctions();
  final ScrollController controller = ScrollController();
  List<BlogsModel> blogs = [];
  List favouriteList = [];
  var isLoading = false.obs;
  // int current_page = 1;
  // var isDataLoading = false;

  Future<void> getData() async {
    // if (!isDataLoading) {
    //   isDataLoading = true;
      List<BlogsModel> newBlogs = await _functions.getBlogs();
      blogs = newBlogs;
      update();
    //   isDataLoading = false;
    // }
  }

  @override
  void onReady() {
    super.onReady();
    Indicator.showLoading();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    _functions.is_loading.listen((p) {
      isLoading.value = p;
    });
    controller.addListener(() {
      double maxScrollPoint = controller.position.maxScrollExtent;
      double currentPosition = controller.position.pixels;
      double height20 = Get.size.height * 0.20;

      if (!isLoading.value && maxScrollPoint - currentPosition <= height20) {
        getData();
      }
    });
  }
}
