import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:get/get.dart';
import 'app/routes/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // name: "flutter_firebase_blog",
      options: const FirebaseOptions(
          apiKey: "Your_API_KEY",
          appId: "YOUR_APP_ID",
          messagingSenderId: "YOUR_MESSAGE_SENDER_ID",
          projectId: "YOUR_PROJECT_ID",
          storageBucket: "YOUR_BUCKET_URL"));
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(
    ScreenUtilInit(
      // designSize: const Size(360, 690),
      builder: (BuildContext context, c) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Firebase Blog",
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
