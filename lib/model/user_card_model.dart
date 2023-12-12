// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<UserCard> infoUserFromJson(String str) => List<UserCard>.from(
      json.decode(str).map((x) => UserCard.fromJson(x)),
    );

String infoUserToJson(List<UserCard> data) => json.encode(
      List<dynamic>.from(data.map((x) => x.toJson())),
    );

class UserCard {
  String title;
  String content;

  UserCard({
    required this.title,
    required this.content,
  });

  UserCard.empty({this.title = 'Titulo', this.content = ''});

  factory UserCard.fromJson(Map<String, dynamic> json) => UserCard(
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
      };

  @override
  bool operator ==(covariant UserCard other) {
    if (identical(this, other)) return true;

    return other.title == title && other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;

  @override
  String toString() => 'UserCard(title: $title, content: $content)';
}
