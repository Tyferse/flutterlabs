import 'package:get/get.dart';

import '../modules/authentication/authentication_binding.dart';
import '../modules/authentication/authentication_view.dart';
import '../modules/blog_detail_screen/blog_detail_screen_binding.dart';
import '../modules/blog_detail_screen/blog_detail_screen_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/my_blogs/my_blogs_binding.dart';
import '../modules/my_blogs/my_blogs_view.dart';
import '../modules/profile/profile_binding.dart';
import '../modules/profile/profile_view.dart';
import '../modules/sign_up/sign_up_binding.dart';
import '../modules/sign_up/sign_up_view.dart';
// import '../modules/title/title_binding.dart';
// import '../modules/title/title_view.dart';
import '../modules/upload_blog/upload_blog_binding.dart';
import '../modules/upload_blog/upload_blog_view.dart';

part 'app_routes.dart';


class AppPages {
  AppPages._();

  static const initial = Routes.authentication;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.sign_in,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.authentication,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.upload_blog,
      page: () => UploadBlogView(),
      binding: UploadBlogBinding(),
    ),
    GetPage(
      name: _Paths.blog_detail,
      page: () => BlogDetailScreenView(),
      binding: BlogDetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.my_blogs,
      page: () => const MyBlogsView(),
      binding: MyBlogsBinding(),
    ),
    // GetPage(
    //   name: _Paths.title,
    //   page: () => const TitleView(),
    //   binding: TitleBinding(),
    // ),
  ];
}
