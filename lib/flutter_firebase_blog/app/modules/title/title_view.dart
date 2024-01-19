import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'title_controller.dart';


class TitleView extends GetView<TitleController> {
  const TitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://api.mediaten.ru/storage/company-service/9/brZzWnfnRLLbfd6OB3xlSh5WkUp7PAs6uQG26F4W.png', width: 36, height: 36,),
            Text(
              "ire",
              style: TextStyle(
                fontSize: 36.sp,
                color: Colors.deepOrange.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "base",
              style: TextStyle(
                fontSize: 36.sp,
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "-",
              style: TextStyle(
                fontSize: 36.sp,
                color: Colors.white30,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              " App",
              style: TextStyle(
                fontSize: 36.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
