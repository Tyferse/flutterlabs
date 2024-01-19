import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/app_bar.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'blog_detail_screen_controller.dart';


class BlogDetailScreenView extends GetView<BlogDetailScreenController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final BlogsModel model = Get.arguments;
  // final CommentController commentController = Get.find();
  final TextEditingController commentEditingController = TextEditingController();

  BlogDetailScreenView({super.key}) {
    Get.put(CommentController());
  }

  @override
  Widget build(BuildContext context) {
    final CommentController commentController = Get.find();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Obx(() {
                const CustomAppBar(title: "Страница поста",),
              SizedBox(height: 10.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                alignment: Alignment.centerLeft,
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 22.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                alignment: Alignment.centerLeft,
                child: Text(
                  model.description,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              Container(alignment: Alignment.topLeft,
                  child: const Text(" Комментарии", style: TextStyle(fontSize: 28),)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: TextField(
                  controller: commentEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Введите комментарий',),
                ),
              ),
              SizedBox(height: 10.h,),
              Container(alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  commentController.addComment(model.id, _auth.currentUser!.uid, commentEditingController.text);
                  commentEditingController.clear();
                  // commentEditingController.clear();
                },
                child: const Text('Добавить комментарий'),
              ),),
              SizedBox(height: 22.h,),
              CommentList(blog_id: model.id),
            ],
          ),
        ),
      ),
    );
  }
}
