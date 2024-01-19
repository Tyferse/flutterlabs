import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/app_bar.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/custom_button.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/text_field.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'upload_blog_controller.dart';


// ignore: must_be_immutable
class UploadBlogView extends GetView<UploadBlogController> {
  UploadBlogView({super.key});
  BlogsModel? model = Get.arguments;

  @override
  Widget build(BuildContext context) {
    if (model != null) {
      controller.title = TextEditingController(text: model!.title);
      controller.description = TextEditingController(text: model!.description);
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const CustomAppBar(title: "Создание поста",),
              SizedBox(height: 20.h,),
              ReusableTextField(
                is_multiline: false,
                hint_text: "Название",
                controller: controller.title,
              ),
              SizedBox(height: 20.h,),
              ReusableTextField(
                hint_text: "Описание",
                controller: controller.description,
                is_multiline: true,
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60.h,
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: CustomButton(
            function: () {
              if (model == null) {
                controller.createBlog();
              }
            },
            title: "Создать пост",
          ),
        ),
      ),
    );
  }
}
