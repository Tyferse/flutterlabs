import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint_text;
  final bool is_multiline;

  const ReusableTextField({required this.hint_text,
    required this.controller,
    required this.is_multiline,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: is_multiline ? 200.h : 55.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: TextField(
        controller: controller,
        maxLines: is_multiline ? null : 1,
        keyboardType: is_multiline ? TextInputType.multiline : null,
        decoration: InputDecoration(
          hintText: hint_text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
