import 'dart:convert';

List<Notif> notifFromJson(String str) =>
    List<Notif>.from(json.decode(str).map((x) => Notif.fromJson(x)));

String notifToJson(List<Notif> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notif {
  Notif({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.isRead,
    required this.actionUrl,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String description;
  String type;
  String isRead;
  String actionUrl;
  String image;
  int userId;
  String createdAt;
  String updatedAt;

  factory Notif.fromJson(Map<String, dynamic> json) => Notif(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        isRead: json["is_read"],
        actionUrl: json["action_url"] ?? 'kosong',
        image: json["image"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "is_read": isRead,
        "action_url": actionUrl,
        "image": image,
        "user_id": userId,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
      };
}
