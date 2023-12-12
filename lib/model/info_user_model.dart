import 'dart:convert';

List<InfoUser> infoUserFromJson(String str) => List<InfoUser>.from(
      json.decode(str).map((x) => InfoUser.fromJson(x)),
    );

String infoUserToJson(List<InfoUser> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class InfoUser {
  String title;
  String content;

  InfoUser({
    required this.title,
    required this.content,
  });

  InfoUser.empty({this.title = 'Titulo', this.content = ''});

  factory InfoUser.fromJson(Map<String, dynamic> json) => InfoUser(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };
}
