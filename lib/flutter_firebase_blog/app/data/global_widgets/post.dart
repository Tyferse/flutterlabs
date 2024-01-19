import 'package:flutterlabs/flutter_firebase_blog/app/models/blog_model.dart';
import 'package:flutterlabs/flutter_firebase_blog/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class Post extends StatelessWidget {
  final BlogsModel model;
  final bool is_pop_up_menu_enabled;
  final Function? delete;

  const Post({
    required this.is_pop_up_menu_enabled,
    required this.model,
    this.delete,
    super.key});

  @override
  Widget build(BuildContext context) {
    Color button_color = Colors.red.shade400;
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.blog_detail, arguments: model);
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(235, 255, 249, 1.0),
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              // Image.
              Container(
                height: 35.h,
                width: 330.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5)
                  ),
                ),
                alignment: Alignment.topRight,
                child: is_pop_up_menu_enabled
                    ? Padding(
                        padding: EdgeInsets.all(3.5.sp),
                        child: ElevatedButton(
                          onPressed: () {
                            delete!();
                          },
                          onHover: (value) {
                            button_color = Colors.red.shade700;
                          },
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: button_color,
                            size: 24,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                model.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
