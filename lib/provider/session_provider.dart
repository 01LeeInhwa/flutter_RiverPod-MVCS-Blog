import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/model/user/user.dart';
import 'package:logger/logger.dart';

final sessionProvider = Provider<SessionUser>((ref) { // 화면이 다시 그려지지 않음
  return SessionUser();
});

// 최초 앱이 실행될 때 초기화 되어야 함.
// 1. JWT 존재 유무 확인 (I/O)
// 2. JWT로 회원정보 받아봄 (I/O)
// 3. OK -> loginSuccess() 호출
// 4. FAIL -> loginPage로 이동
class SessionUser {
  User? user;
  String? jwt;
  bool? isLogin;

  void loginSuccess(User user, String jwt){
    this.user = user;
    this.jwt = jwt;
    this.isLogin = true;
  }

  Future<void> logoutSuccess() async{// I/O가 발생하는 모든 통신은 async await
    this.user = null;
    this.jwt = null;
    this.isLogin = false;
    await secureStorage.delete(key: "jwt"); // Future<void>가 아니면 안기다리고 실행
    Logger().d("세션 종료 및 디바이스 JWT 삭제");
  }
}