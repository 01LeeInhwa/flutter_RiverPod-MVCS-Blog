import 'package:flutter/material.dart';
import 'package:flutter_riverpod_blog_start/view/pages/auth/join_page/join_page.dart';
import 'package:flutter_riverpod_blog_start/view/pages/auth/login_page/login_page.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/post_home_page.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/write_page/post_write_page.dart';
import 'package:flutter_riverpod_blog_start/view/pages/user/detail_page/user_detail_page.dart';

class Move {

  Move._single(); // 생성자 만들어서 기본 생성자X  : Move() 자꾸 생겨서!

  static String postHomePage = "/post/home";
  static String postWritePage = "/post/write";
  static String joinPage = "/join";
  static String loginPage = "/login";
  static String userDetailPage = "/user/detail";
}


Map<String, Widget Function(BuildContext)> getRouters() {
  return {
    Move.joinPage: (context) => JoinPage(),
    Move.loginPage: (context) => LoginPage(),
    Move.postHomePage: (context) => PostHomePage(),
    Move.postWritePage: (context) => PostWritePage(),
    Move.userDetailPage: (context) => const UserDetailPage(),
  };
}
