

import 'package:flutter_riverpod_blog_start/model/user/user.dart';

// 최초 앱이 실행될 때 초기화 되어야 함.
// 1. JWT 존재 유무 확인(이 토큰이 유효한지 확인)
// 2. JWT로 회원정보 받아봄 (I/O)
// 3. OK -> loginSucess() 호출
// 4. FAIL -> loginPage로 이동
class SessionUser { // 전역적으로 -> 통으로 넣기
  User? user;
  String? jwt;
  bool? isLogin; // true면 로그인된 상태


  void LoginSucess(User user, String jwt){ // 핸들러 만든다고 생각!

    // 1일 때(로그인시 1로 설정) 정보 들어옴
    this.user = user;
    this.jwt = jwt;
    this.isLogin = true;

  }

  void LogoutSucess(){
    this.user = null; // 강제로 날림
    this.jwt = null;
    this.isLogin = false;
  }
}