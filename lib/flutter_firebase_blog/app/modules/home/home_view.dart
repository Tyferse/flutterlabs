import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/post.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home_controller.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Future<void> _refresh() async {
    await controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network('https://api.mediaten.ru/storage/company-service/9/brZzWnfnRLLbfd6OB3xlSh5WkUp7PAs6uQG26F4W.png', width: 22, height: 22,),
                      Text(
                        "ire",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.deepOrange.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "base",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "-",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " App",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.profile);
                    },
                    icon: Icon(
                      Icons.account_box,
                      size: 25.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Expanded(
            //   child: GetBuilder<HomeController>(
            //     builder: (value) {
            //       if (value.blogs.isNotEmpty) {
            //         return ListView.builder(
            //           itemCount: value.blogs.length,
            //           itemBuilder: (context, index) {
            //             return Padding(
            //               padding: EdgeInsets.symmetric(
            //                 horizontal: 15.sp,
            //                 vertical: 5.sp,
            //               ),
            //               child: Post(
            //                 is_pop_up_menu_enabled: false,
            //                 model: value.blogs[index],
            //               ),
            //             );
            //           },
            //         );
            //       }
            //       else {
            //         return const Center(child: Text("Нет доступных постов"),);
            //       }
            //     },),
            // ),
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (value) {
                  if (value.blogs.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                        controller: controller.controller,
                        itemCount: value.blogs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp, vertical: 2.sp),
                            child: Post(
                              is_pop_up_menu_enabled: false,
                              model: value.blogs[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  else {
                    return const Center(child: Text("Нет доступных блогов."),);
                  }
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (controller.current_page > 1) {
            //       controller.current_page -= 1;
            //     }
            //
            //     controller.getData();
            //
            //     Scrollable.ensureVisible(context,
            //         duration: Duration(milliseconds: 500),
            //         curve: Curves.easeInOut);
            //   },
            //   child: Text('Прокрутить вверх'),
            // ),
            // // Кнопка прокрутки вниз
            // ElevatedButton(
            //   onPressed: () {
            //     controller.current_page += 1;
            //     controller.getData();
            //
            //     Scrollable.ensureVisible(context,
            //         duration: Duration(milliseconds: 500),
            //         curve: Curves.easeInOut,
            //         alignment: 1.0);
            //   },
            //   child: Text('Прокрутить вниз'),
            // ),
            Obx(() {
              if (controller.isLoading.value) {
                return SizedBox(
                  height: 60.h,
                  child: const CircularProgressIndicator.adaptive(),
                );
              }
              else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
