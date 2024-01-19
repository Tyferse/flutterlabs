// import 'dart:ffi';

import 'package:flutterlabs/flutter_firebase_blog/app/data/firebase/firebase_auth.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/tiles.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/title_logo.dart';
// import 'package:flutterlabs/flutter_firebase_blog/app/modules/home/home_controller.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/modules/my_blogs/my_blogs_controller.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'profile_controller.dart';


class ProfileView extends GetView<ProfileController> {
  final FirebaseAuthentication _authentication = FirebaseAuthentication();
  ProfileView({super.key}) {
    Get.put(ProfileController());
    Get.put(MyBlogsController());
  }

  @override
  Widget build(BuildContext context) {
    controller.getCurrentUserName();
    MyBlogsController myBlogsController = Get.find<MyBlogsController>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 40.h,),
                const TitleLogo(),
                SizedBox(height: 20.h,),
                Icon(Icons.account_box_rounded, size: 80.h,),
                SizedBox(height: 20.h,),
                Center(
                  child: Obx(() => Text(
                    controller.userName.value,
                    style: const TextStyle(color: Colors.black, fontSize: 36),
                  )),
                ),
                // FutureBuilder<String>(
                //   future: controller.getCurrentUserName(),
                //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.done) {
                //       if (snapshot.hasData) {
                //         return Center(
                //           child: Text(
                //             snapshot.data!,
                //             style: const TextStyle(color: Colors.black, fontSize: 36),
                //           ),
                //         );
                //       }
                //       else {
                //         return const Center(
                //           child: Text('User Name Not Found',
                //             style: TextStyle(color: Colors.red, fontSize: 36),
                //           ),
                //         );
                //       }
                //     }
                //     else {
                //       return const Center(child: CircularProgressIndicator(),);
                //     }
                //     },
                // ),
                SizedBox(height: 25.h,),
                Tile(
                  title: "Главная страница",
                  icon: Icons.home,
                  function: () {
                    Get.toNamed(Routes.home);
                  },
                ),
                Tile(
                  title: "Мой блог",
                  icon: Icons.edit_note,
                  function: () {
                    Get.toNamed(Routes.my_blogs);
                  },
                ),
                Tile(
                  title: "Выйти из аккаунта",
                  icon: Icons.logout_sharp,
                  function: () {
                    myBlogsController.my_blogs.clear();
                    _authentication.logOut();
                  },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
