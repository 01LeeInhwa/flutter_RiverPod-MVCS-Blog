

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';

// 창고 관리자
// 순서 : 창고, 창고데이터?(? : null일 수도 있음)
// autoDispose : pop될 때 데이터창고를 날려버림
final postHomePageProvider = StateNotifierProvider.autoDispose<PostHomePageViewModel, PostHomePageModel?>((ref) {
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostHomePageViewModel(null)..notifyInit(sessionUser.jwt!);
});


// 창고 데이터 :
class PostHomePageModel {
  List<Post> posts;
  //생성자 필요
  PostHomePageModel({required this.posts});

}

// 창고
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);

  // 창고 초기화 : 통신 2번
  // view한테 알려줌
  void notifyInit(String jwt) async{
    ResponseDTO responseDTO = await PostRepository().fetchPostList(jwt);
    state = PostHomePageModel(posts: responseDTO.data);
  }

  // 추가 : collection일 때 가능
  void notifyAdd(Post post){
      List<Post> posts = state!.posts; // 기존 posts는 state가 가지고 있음
      List<Post> newPosts = [post ,...posts ];
      state = PostHomePageModel(posts: newPosts);
  }

  // 삭제
  void notifyRemove(int id){
      List<Post> posts = state!.posts; // 기존 posts는 state가 가지고 있음
      List<Post> newPosts = posts.where((e) => e.id != id).toList();
      state = PostHomePageModel(posts: newPosts);

  }

  // 수정
  void notifyUpdate(Post post){
    List<Post> posts = state!.posts; // 기존 posts는 state가 가지고 있음
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }


}