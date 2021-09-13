// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.noKtp,
    required this.imageKtp,
    required this.isVerified,
    required this.role,
    required this.emailVerifiedAt,
    required this.currentTeamId,
    required this.profilePhotoPath,
    required this.scanCounter,
    required this.fcmToken,
    required this.apiToken,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePhotoUrl,
  });

  int id;
  String name;
  String email;
  String address;
  String phone;
  String noKtp;
  String imageKtp;
  String isVerified;
  String role;
  dynamic emailVerifiedAt;
  dynamic currentTeamId;
  String profilePhotoPath;
  int scanCounter;
  dynamic fcmToken;
  String apiToken;
  String createdAt;
  String updatedAt;
  String profilePhotoUrl;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        noKtp: json["no_ktp"],
        imageKtp: json["image_ktp"],
        isVerified: json["is_verified"],
        role: json["role"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        scanCounter: json["scan_counter"],
        fcmToken: json["fcm_token"],
        apiToken: json["api_token"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "no_ktp": noKtp,
        "image_ktp": imageKtp,
        "is_verified": isVerified,
        "role": role,
        "email_verified_at": emailVerifiedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "scan_counter": scanCounter,
        "fcm_token": fcmToken,
        "api_token": apiToken,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "profile_photo_url": profilePhotoUrl,
      };
}
