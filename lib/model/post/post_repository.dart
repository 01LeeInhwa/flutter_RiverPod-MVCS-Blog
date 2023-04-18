import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/post_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';

class PostRepository {
  static final PostRepository _instance = PostRepository._single();

  factory PostRepository() {
    return _instance;
  }

  PostRepository._single();

  Future<ResponseDTO> fetchPostList(String jwt) async {
    try {
      Response response = await dio.get("/post",
          options: Options(
            // header를 추가하고싶을 때 사용
            headers: {
              "Authorization": "$jwt" // 받아오면됨!
            },
          ));
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      List<dynamic> mapList =
          responseDTO.data as List<dynamic>; // as List<dynamic> 생략가능 : 묵시적 변환
      // e : post처럼 생긴 map
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      responseDTO.data = postList;
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchPost(int id, String jwt) async {
    // 나중에 jwt는 인터셉터 사용
    try {
      Response response = await dio.get("/post/$id",
          options: Options(
            // header를 추가하고싶을 때 사용
            headers: {
              "Authorization": "$jwt" // 받아오면됨!
            },
          ));
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchDelete(int id, String jwt) async {
    // 나중에 jwt는 인터셉터 사용
    try {
      Response response = await dio.delete("/post/$id",
          options: Options(
            // header를 추가하고싶을 때 사용
            headers: {
              "Authorization": "$jwt" // 받아오면됨!
            },
          ));
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  // Api문서 body 확인 : 필요한 DTO
  Future<ResponseDTO> fetchUpdate(
      int id, PostUpdateReqDTO postUpdateReqDTO, String jwt) async {
    // 나중에 jwt는 인터셉터 사용
    try {
      Response response = await dio.put(
        "/post/$id",
        options: Options(
          // header를 추가하고싶을 때 사용
          headers: {
            "Authorization": "$jwt" // 받아오면됨!
          },
        ),
        data: postUpdateReqDTO.toJson(),
      );
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchSave(PostSaveReqDTO postSaveReqDTO, String jwt) async {
    // 나중에 jwt는 인터셉터 사용
    try {
      Response response = await dio.post("/post",
          options: Options(
            // header를 추가하고싶을 때 사용
            headers: {
              "Authorization": "$jwt" // 받아오면됨!
            },
          ), data: postSaveReqDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }
}
