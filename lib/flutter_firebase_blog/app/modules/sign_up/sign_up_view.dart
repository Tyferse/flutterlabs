import 'package:flutterlabs/flutter_firebase_blog/app/data/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/global_widgets/title_logo.dart';
import 'sign_up_controller.dart';


class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 80.h,),
            const TitleLogo(),
            SizedBox(height: 60.h,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Text("Регистрация", style: TextStyle(
                fontSize: 25.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller.full_name,
                decoration: InputDecoration(
                    labelText: 'Полное имя',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller.email,
                decoration: InputDecoration(
                    labelText: 'Электронная почта',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: controller.password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Пароль',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
            ),
            SizedBox(height: 20.h,),
            CustomButton(function: () {controller.onCreateAccount();},
                title: "Создать Аккаунт"),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.h,
        child: GestureDetector(
          onTap: () {Get.back();},
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Уже есть аккаунт? ", style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,),),
                Text("Войти", style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),)
              ])
        ),
      ),
    );
  }
}
