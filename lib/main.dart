import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'model/user/user_repository.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  // MyApp 시작전에 필요한 것 여기서 다 로딩 (동기적 실행)
  WidgetsFlutterBinding.ensureInitialized(); // runApp 전에 비동기 데이터가 있으면 다 다운 받고 실행

  // 1. 시큐어 스토리지에 JWT 있는지 확인
  // 2. JWT를 가지고 회원정보를 가져와서
  // 3. SessionUser 동기화 (ref에 접근해야함)
  SessionUser sessionUser = await UserRepository().fetchJwtVerify();


  runApp(
    ProviderScope(
      overrides: [
        sessionProvider.overrideWithValue(sessionUser)
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SessionUser sessionUser = ref.read(sessionProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: sessionUser.isLogin! ? Move.postHomePage : Move.loginPage,
      routes: getRouters(),
    );
  }
}