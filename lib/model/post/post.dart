import 'package:flutter_riverpod_blog_start/model/user/user.dart';
import 'package:intl/intl.dart';

class Post {
  final int id;
  final String title;
  final String content;
  final User user;
  final DateTime created;
  final DateTime updated;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toJson() => { // toJson이지만 실제로는 toMap
    "id": id,
    "title": title,
    "content": content,
    "user": user,
    "created": created,
    "updated": updated
  };

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        user = User.fromJson(json["user"]),
        created = DateFormat("yyyy-mm-dd").parse(json["created"]), // intl 라이브러리 사용
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}