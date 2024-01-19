import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/app_bar.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import "../../routes/app_routes.dart";
import '../../routes/app_pages.dart';
import '../home/home_controller.dart';
import 'my_blogs_controller.dart';


class MyBlogsView extends GetView<MyBlogsController> {
  const MyBlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomAppBar(title: "Мой блог",
              button: IconButton(onPressed: () {Get.toNamed(Routes.home);},
                  icon: const Icon(Icons.home_outlined)),),
            SizedBox(height: 20.h,),
            Expanded(
              child: GetBuilder<MyBlogsController>(
                builder: (value) {
                  if (value.my_blogs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: value.my_blogs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.sp,
                            vertical: 5.sp,
                          ),
                          child: Post(
                            delete: () {
                              controller.deleteBlog(value.my_blogs[index].id);
                              controller.my_blogs.removeAt(index);
                            },
                            is_pop_up_menu_enabled: true,
                            model: value.my_blogs[index],
                          ),
                        );
                      },
                    );
                  }
                  else {
                    return const Center(child: Text("Нет доступных постов"),);
                  }
                  },),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () {
              Get.toNamed(Routes.upload_blog);
            },
            label: Row(
              children: [
                Icon(
                  Icons.post_add,
                  size: 24.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Создать пост",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white
                  ),
                )
              ],
            )),
      ),
    );
  }
}
